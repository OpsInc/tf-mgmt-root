resource "aws_cognito_user_pool" "pool" {
  name = var.project_identifier

  alias_attributes = [
    "email",
  ]

  auto_verified_attributes = [
    "email",
  ]

  deletion_protection        = "INACTIVE"
  mfa_configuration          = "OFF"
  sms_authentication_message = "Your authentication code is {####}. "

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = true

    invite_message_template {
      email_message = "Your username is {username} and temporary password is {####}. "
      email_subject = "Your temporary password"
      sms_message   = "Your username is {username} and temporary password is {####}. "
    }
  }

  device_configuration {
    challenge_required_on_new_device      = false
    device_only_remembered_on_user_prompt = false
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "Your verification code is {####}. "
    email_subject        = "Your verification code"
    sms_message          = "Your verification code is {####}. "
  }

  tags = var.common_tags
}

resource "aws_cognito_user_pool_domain" "hosted_ui" {
  domain       = var.project_identifier
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_client" "userpool_client" {
  name                                 = "${var.project_identifier}-app"
  user_pool_id                         = aws_cognito_user_pool.pool.id
  callback_urls                        = ["https://${var.domain_name}"]
  logout_urls                          = ["https://${var.domain_name}"]
  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  prevent_user_existence_errors        = "ENABLED"
  allowed_oauth_flows                  = ["implicit"]
  allowed_oauth_scopes                 = ["aws.cognito.signin.user.admin", "email", "openid", "phone", "profile"]
  supported_identity_providers         = ["COGNITO"]
}
