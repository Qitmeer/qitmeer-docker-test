# This is the directory for all the Terraform scripts for HLC tests

Use AWS Spot instances to run all the test cases

## Prepare infrastructure for test cases

### Initialize the Terraform backend state file

```
terraform init --backend=true -backend-config=init.config
```

### Review the AWS resources to be created

```
terraform plan -var-file=production.tfvars
```

### Save your public SSH key in "test_ec2_key.pub"

### Create AWS resources

```
terraform apply -var-file=production.tfvars
```
