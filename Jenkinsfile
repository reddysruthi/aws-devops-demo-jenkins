pipeline {
    agent {
        label 'terraform'
    }
    environment {
         AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id') 
         AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
    }
    stages {
        stage('initialize terraform') {
            steps {
                sh 'terraform init'
            }
        }
        stage('format config files') {
            steps {
                sh 'terraform fmt -check=0 || exit 1'
            }
        }
        stage('validate config file') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('generate plan') {
            steps {
                sh 'terraform plan -out=terraformplan'
                sh 'terraform show -json ./terraformplan > terraform_plan.json'
            }
        }
        stage('publish artifacts for terraform plan') {
            steps {
                archiveArtifacts artifacts: 'terraform_plan.json', excludes: 'output/*.md', onlyifsuccessful: true
            }
        }
        stage('terraform apply or not?') {
            steps {
                script {
                    env.selected_action = input  message: 'Select action to perform',ok : 'Proceed',id :'tag_id',
                    parameters:[choice(choices: ['apply', 'destroy', 'abort'], description: 'select action', name: 'action')]
                }
            }

        }
        stage('terraform apply') {
            steps {
                script {
                    if (env.selected_action == "apply") {
                        sh 'terraform apply -auto-approve'
                    } else if(env.selected_action == "destroy") {
                        sh 'terraform destroy -auto-approve'
                    } else {
                        echo 'No need to create a resource as of now,so aborted!!!'
                    }
                }
            }
        }
    }
}
