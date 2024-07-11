pipeline {
    agent { node { label 'node-slave' } } 
    parameters {
                choice(name: 'deploy_choice', choices:['apply','destroy'],description:'The deployment type')
                  }
    environment {
        EMAIL_TO = 'ajisegbedeabisolat@gmail.com'
    }
    stages {
        stage('1.Terraform init') {
            steps {
                echo 'terraform init phase'
                sh 'terraform init -reconfigure'
            }
        }
        stage('2.Terraform plan') {
            steps {
                echo 'terraform plan phase'
                sh 'AWS_REGION=us-west-1 terraform plan'
            }
        }
        stage('3.Manual Approval') {
            input {
                message "Should we proceed?"
                ok "Yes, we should."
                parameters{
                    choice (name: 'Manual_Approval', choices: ['Approve','Reject'], description: 'Approve or Reject the deployment')
                }
            }
             steps {
                echo "Deployment ${Manual_Approval}"
            }          
        }
        stage('4.Terraform Deploy') {              
            steps { 

                withKubeConfig(caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJRVhicG5mTVZ5WVl3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBM01EZ3hPRE13TkRsYUZ3MHpOREEzTURZeE9ETTFORGxhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUNmK1NMbGE1Z3ZZeVk5YitVNmZZWit4QUg4MHYvRFl4dnV3TCtJQkhTRlRYQlFDRUxIVDlKMS9YMXAKMmJ6NWswK1BtMjNSZm00dzcvMzdUOE91WkN1SGx5QmNLempML0Z2QVdHa2hjTTg1cW1QNkdVbVl5V2tpYUJhSQpiSlkxM2dWODhuRmUyb015cXd5Y3FrZ1pMd0VsYkJhdFZpam5LeGtsakhiNWFkVGFrMWcybjlmSFl0ZmNyUDRlCmpLUGh4WEZQeFR4Y0ZsUUd6ZlgzUGRQSk5oUnNISVJZTDZEUjNYWGU0QTZpRHowcjNqbTRpKzlkZlF6cW8xQS8KaDNObGVEdWNhOWZRbnZvMUVpTmFXTVF4YUo0WWlNcmJzSG1IWlUxQTFNK0tDYy84UGZpcklVSXdXa3VLQWtnMApxaDQzZjNkSTFwdjJ2TU9pUjlBK0U5R3RnYmRqQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJRdzd5QkdPZ0RrbzRoZjBXMmFnNVgwTEdMeDFUQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQ2J1QnFCVFpUagpqZjBzK3lpQnY2eVl5N3FDRVdSRG1nSFFTc0xDSG5zT1F3aGRMT2pCQXp5OUNxc1JEa1FIZEs0TG9XQm5zVVJzCnhZK1oxc2F5WHg4N28xRUVDWmY2WVlYWHhjaHVsdWZ3UE0vSnpib3VoVmJoblMxYWFzbDgwc2thOG5YZGVnNnoKSXphd1VVQjVoRlBVa3dVV3lxMnJmVUVuemRUTkJLSWZXSXkxdWk2WjZaTTBwOVJZeHFuYmVoUWt0U2NNb3BGNwpMejlCK016bCtDbmdKT09zbkRZVHRUUWV4NkdyWEp5QUpaamJGcGR4OFJ4MXc2dzVGbkV0R2plYnA3V3hndXRqCll4VnJiUmU4bFlDTVV0elRUbDhpWTBhUHY3QTlqWHlXZmd3dk1NOC8xcHhBV2lrSGVPSXZMY1o5Q0p1U1NDRnkKMG9tOUNKODJYZEhNCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K',
                 clusterName: 'dominion-cluster', contextName: 'arn:aws:eks:us-west-1:339712774185:cluster/dominion-cluster', credentialsId: 'k8s-kubeconfig', namespace: 'directory', restrictKubeConfigAccess: false, serverUrl: 'https://7A3978DBFC082919F19E9CFAB2201D4B.gr7.us-west-1.eks.amazonaws.com')
                 {


                echo 'Terraform ${params.deploy_choice} phase'  
                sh "AWS_REGION=us-west-1 terraform ${params.deploy_choice}  -target=module.vpc -target=module.eks -target= module.aws-alb-controller --auto-approve"
                sh "aws eks --region us-west-1 update-kubeconfig --name dominion-cluster && export KUBE_CONFIG_PATH=~/.kube/config"
                sh "AWS_REGION=us-west-1 terraform ${params.deploy_choice} --auto-approve"
                 }
            }
                }
        stage ('5. Email Notification') {
            steps {
               mail bcc: 'ajisegbedeabisolat@gmail.com', body: '''Terraform deployment is completed.
               Let me know if the changes look okay.
               Thanks,
               Dominion System Technologies,
              08156048097''', cc: 'ajisegbedeabisolat@gmail.com', from: '', replyTo: '', subject: 'Terraform Infra deployment completed!!!', to: 'ajisegbedeabisolat@gmail.com'
                          
               }    
          }
     }       
}   
