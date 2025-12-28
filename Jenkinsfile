pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply'],
            description: 'Select the action to perform'
        )
    }

    environment {
        GOGC = "20"
    }

    stages {
       stage('Checkout') {
    steps {
       checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Satish2109-Devops/Terraform-Automation.git']])

    }
}
    
        stage ("terraform init") {
            steps {
                sh ("terraform init -reconfigure") 
            }
        }
        
 

        stage (" Action") {
            steps {
                script {
                    switch (params.ACTION) {
                        case 'plan':
                            echo 'Executing Plan with memory optimization...'
                            sh '''
                                terraform plan -parallelism=2 -lock=false
                            '''
                            break
                        case 'apply':
                            echo 'Executing Apply with memory optimization...'
                            sh '''
                                terraform apply -parallelism=2 -lock=false --auto-approve
                            '''
                            break
                        default:
                            error 'Unknown action'
                    }
                }
            }
        }
    }
}
