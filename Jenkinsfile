pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                sh 'terraform init'
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
                sh 'terraform validate'
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
                sh 'terraform plan'
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
                sh 'terraform apply --auto-approve'
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
                def logResult = sh(script: "aws lambda invoke --function-name \"DevOps-Candidate-Lambda\" --region \"ap-south-1\" --log-type Tail output.txt", returnStdout: true).trim()
                def encodedLogResult = sh(script: "echo ${logResult} | jq -r '.LogResult' | base64 --decode", returnStdout: true).trim()
                echo "Encoded Log Result: ${encodedLogResult}"
            }
        }
    }
}
