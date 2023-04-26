resource "aws_api_gateway_rest_api" "create_api" {
  name = var.project_identifier

  tags = var.common_tags
}

resource "aws_api_gateway_resource" "resource_path_parent" {
  for_each = var.apps

  parent_id   = aws_api_gateway_rest_api.create_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.create_api.id
  path_part   = each.value.name
}

resource "aws_api_gateway_resource" "resource_path_wildcard" {
  for_each = var.apps

  parent_id   = aws_api_gateway_resource.resource_path_parent[each.key].id
  rest_api_id = aws_api_gateway_rest_api.create_api.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name = "${var.project_identifier}-cognito"

  rest_api_id   = aws_api_gateway_rest_api.create_api.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [var.cognito_arn]
}

########################################
###             METHODS              ###
########################################
###POST
resource "aws_api_gateway_method" "post_method" {
  for_each = var.apps

  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.resource_path_wildcard[each.key].id
  rest_api_id   = aws_api_gateway_rest_api.create_api.id

  request_parameters = {
    "method.request.header.Authorization" = true
  }
}

resource "aws_api_gateway_method_response" "post_200" {
  for_each = var.apps

  rest_api_id = aws_api_gateway_rest_api.create_api.id
  resource_id = aws_api_gateway_resource.resource_path_wildcard[each.key].id
  http_method = aws_api_gateway_method.post_method[each.key].http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "post_integration" {
  for_each = var.apps

  http_method             = aws_api_gateway_method.post_method[each.key].http_method
  resource_id             = aws_api_gateway_resource.resource_path_wildcard[each.key].id
  rest_api_id             = aws_api_gateway_rest_api.create_api.id
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambdas[each.key].invoke_arn
}

resource "aws_api_gateway_integration_response" "post_integration_response" {
  for_each = var.apps

  rest_api_id = aws_api_gateway_rest_api.create_api.id
  resource_id = aws_api_gateway_resource.resource_path_wildcard[each.key].id
  http_method = aws_api_gateway_method.post_method[each.key].http_method
  status_code = aws_api_gateway_method_response.post_200[each.key].status_code

  depends_on = [
    aws_api_gateway_integration.post_integration
  ]
}

### OPTIONS
#tfsec:ignore:aws-api-gateway-no-public-access
resource "aws_api_gateway_method" "options_method" {
  for_each = var.apps

  resource_id   = aws_api_gateway_resource.resource_path_wildcard[each.key].id
  rest_api_id   = aws_api_gateway_rest_api.create_api.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "options_200" {
  for_each = var.apps

  rest_api_id = aws_api_gateway_rest_api.create_api.id
  resource_id = aws_api_gateway_resource.resource_path_wildcard[each.key].id
  http_method = aws_api_gateway_method.options_method[each.key].http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers"     = true,
    "method.response.header.Access-Control-Allow-Methods"     = true,
    "method.response.header.Access-Control-Allow-Origin"      = true,
    "method.response.header.Access-Control-Allow-Credentials" = true
  }
}

resource "aws_api_gateway_integration" "options_integration" {
  for_each = var.apps

  rest_api_id = aws_api_gateway_rest_api.create_api.id
  resource_id = aws_api_gateway_resource.resource_path_wildcard[each.key].id
  http_method = aws_api_gateway_method.options_method[each.key].http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  for_each = var.apps

  rest_api_id = aws_api_gateway_rest_api.create_api.id
  resource_id = aws_api_gateway_resource.resource_path_wildcard[each.key].id
  http_method = aws_api_gateway_method.options_method[each.key].http_method
  status_code = aws_api_gateway_method_response.options_200[each.key].status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers"     = "'*'",
    "method.response.header.Access-Control-Allow-Methods"     = "'OPTIONS,POST'",
    "method.response.header.Access-Control-Allow-Origin"      = "'*'",
    "method.response.header.Access-Control-Allow-Credentials" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.options_integration
  ]
}

resource "aws_lambda_permission" "apigw_lambda" {
  for_each = var.apps

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = var.lambdas[each.key].function_name

  source_arn = "${aws_api_gateway_rest_api.create_api.execution_arn}/*/${aws_api_gateway_method.post_method[each.key].http_method}${aws_api_gateway_resource.resource_path_wildcard[each.key].path}"
}

#######################################
##            Deployment            ###
#######################################
resource "aws_api_gateway_deployment" "define_deployment" {
  rest_api_id = aws_api_gateway_rest_api.create_api.id

  # triggers = {
  #   redeployment = sha1(jsonencode([
  #     aws_api_gateway_resource.resource_path_wildcard[each.key].id,
  #     aws_api_gateway_method.post_method[each.key].id,
  #     aws_api_gateway_method.options_method[each.key].id,
  #     aws_api_gateway_integration.post_integration[each.key].id,
  #     aws_api_gateway_integration.options_integration[each.key].id,
  #     aws_api_gateway_integration_response.options_integration_response[each.key].id,
  #     aws_api_gateway_integration_response.post_integration_response[each.key].id,
  #     aws_api_gateway_method_response.post_200[each.key].id,
  #     aws_api_gateway_method_response.options_200[each.key].id,
  #   ]))
  # }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration_response.options_integration_response,
    aws_api_gateway_integration_response.post_integration_response,
  ]
}

########################################
###             Stages               ###
########################################
#tfsec:ignore:aws-api-gateway-enable-tracing
resource "aws_api_gateway_stage" "default" {
  deployment_id = aws_api_gateway_deployment.define_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.create_api.id
  stage_name    = "default"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.stage_log_group.arn
    format = jsonencode(
      {
        caller         = "$context.identity.caller"
        httpMethod     = "$context.httpMethod"
        ip             = "$context.identity.sourceIp"
        protocol       = "$context.protocol"
        requestId      = "$context.requestId"
        requestTime    = "$context.requestTime"
        resourcePath   = "$context.resourcePath"
        responseLength = "$context.responseLength"
        status         = "$context.status"
        user           = "$context.identity.user"
      }
    )
  }

  tags = var.common_tags
}

resource "aws_cloudwatch_log_group" "stage_log_group" {
  name = "/aws/apigateway/stage_access_log-${var.project_identifier}"

  kms_key_id = var.kms_global_arn

  tags = var.common_tags
}

########################################
###               Logs               ###
########################################
resource "aws_api_gateway_method_settings" "logs" {
  rest_api_id = aws_api_gateway_rest_api.create_api.id
  stage_name  = aws_api_gateway_stage.default.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_iam_role" "cloudwatch" {
  name = "cloudwatch-${var.project_identifier}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.common_tags
}

# Allows Lambda to send logs to cloudwatch
resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.cloudwatch.name
}

resource "aws_api_gateway_account" "logs" {
  cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}
