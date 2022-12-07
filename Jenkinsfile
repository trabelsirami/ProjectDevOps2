pipeline { 
    agent any
    
     stages {
       stage ('Checkout GIT'){
                steps {
                    echo 'pulling... ';
                        git branch :'Rami',
                        url : 'https://github.com/trabelsirami/ProjectDevOps2.git';
                }
            }
             

        
        stage("mvn build") {
            steps {
                script {
                    // If you are using Windows then you should use "bat" step
                    // Since unit testing is out of the scope we skip them
                    sh "mvn package -DskipTests=true"
                }
            }
        }
      }
     }
      