# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "development" {
  inputs = {
    regions        = ["us-east-1"]
    #role_arn       = "<Set to your development AWS account IAM role ARN>"
    role_arn       = "arn:aws:iam::482424472779:role/stacks-hudi-test-stack-test-lambda-component-expansion-stack"
    identity_token = identity_token.aws.jwt
    default_tags   = { stacks-preview-example = "lambda-component-expansion-stack" }
  }
}

deployment "production" {
  inputs = {
    regions        = ["us-east-1", "us-west-1"]
    role_arn       = "arn:aws:iam::482424472779:role/stacks-hudi-test-stack-test-lambda-component-expansion-stack"
    identity_token = identity_token.aws.jwt
    default_tags   = { stacks-preview-example = "lambda-component-expansion-stack" }
  }
}

/*
orchestrate "auto_approve" "safe_plans" {
  # Ensure that no resources are being removed
  check { 
    condition = context.plan.changes.remove == 0 
    reason = "Plan has ${context.plan.changes.remove} resources to be destroyed." 
  }

  # Ensure that the deployment is not production or disaster-recovery
  check { 
    condition = context.plan.deployment.name != "production" && context.plan.deployment.name != "disaster-recovery" 
    reason = "Production and Disaster Recovery plans are not eligible for auto_approve." 
  } 
}
*/
