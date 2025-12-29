pipeline {
    agent any

    parameters {
         string(
            name: 'BRANCH',
            defaultValue: 'main',
            description: 'Enter Git branch name to perform'
        )
        
        choice(
            name: 'ACTION',
            choices: ['Plan', 'Apply'],
            description: 'Select the action to perform'
        )
    
    }

   

    stages {
       stage('Checkout') {
    steps {
           checkout scmGit(branches: [[name: '*/${BRANCH}']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Satish2109-Devops/Terraform-Automation.git']])


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
                        case 'Plan':
                            echo 'Executing Plan...'
                            sh "terraform plan"
                            break
                        case 'Apply':
                            echo 'Executing Apply...'
                            sh "terraform apply --auto-approve"
                            break
                        default:
                            error 'Unknown action'
                    }
                }
            }
        }
    }
}
