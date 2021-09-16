package test

import (
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the Terraform module in examples/terraform-aws-sagemaker-example using Terratest.
func TestTerraformLambdaExample(t *testing.T) {
	t.Parallel()

	targetRegions := []string{"us-east-1"}

	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(dir)
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples",
		// Variables to pass to our Terraform code using -var options
		VarFiles: []string{"../env-config/dev.tfvars"},
		NoColor:  false,

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	planOut := terraform.InitAndPlan(t, terraformOptions)

	assert.Contains(t, planOut, "module.alb.aws_acm_certificate.acm_certificate will be created")
	assert.Contains(t, planOut, "module.alb.aws_alb_target_group_attachment.server will be created")
	assert.Contains(t, planOut, "module.alb.aws_lb.public will be created")
	assert.Contains(t, planOut, "module.alb.aws_lb_listener.http will be created")
	assert.Contains(t, planOut, "module.alb.aws_lb_listener_rule.host_based_routing[0] will be created")
	assert.Contains(t, planOut, "module.alb.aws_lb_target_group.https will be created")
	assert.Contains(t, planOut, "module.alb.aws_route53_record.jenkins[0] will be created")
	assert.Contains(t, planOut, "module.alb.aws_security_group.jenkins will be created")
	assert.Contains(t, planOut, "Plan: 8 to add, 0 to change, 0 to destroy.")
}
