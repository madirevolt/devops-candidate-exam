pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                terraform init
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
                terraform validate
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
                terraform plan
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
                terraform apply
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
            }
        }
    }
}
