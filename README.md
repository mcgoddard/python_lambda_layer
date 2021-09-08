# Lambda layers with Python

Small demo of deploying some code that is common to several lambda functions using lambda layers. This helps reduce the size of code that needs to be deployed, especially where many third party dependencies would need to be included.

This project contains source code for 2 lambda functions (written in Python) and a common lib (one small helper function, but could easily be much more including pip packages) that will be shared with them using lambda layers. It also contains the Terraform code to deploy both lambdas and the layer that supports them.

## Dependencies

You'll need terraform available to deploy this stack, this was developed using terraform `v0.14.0`.

## Deploy

Deploy the stack with your desired AWS profile selected. Navigate to the `terraform` directory and run:
```
terraform init
terraform apply
```

## Check results

Jump into your AWS console, `lambda_1` when initially executed should return:
```
{
    "parameter_name": "Initial value"
}
```
Executing `lambda_2` will return:
```
{
    "parameter_name": "<current_time>"
}
```
Rerunning `lambda_1` should then give the same value.

## Tear down

To remove all deployed resources navigate to the `terraform` directory and run:
```
terraform destroy
```
