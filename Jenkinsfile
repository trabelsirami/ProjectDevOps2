pipeline { 
    agent any
     environment {
	
           DOCKERHUB_CREDENTIALS= credentials('trrami') 
        
    }
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
        stage('Building our image') {
steps{
sh 'docker build -t ramitr/ramiexam:1.0.0 .'
		}
	}
		stage('Login to Docker Hub') {      	
    steps{                       	
	   sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR -p ${DOCKERHUB_CREDENTIALS_PSW} ${DOCKERHUB_CREDENTIALS_REPOSITORY} '        
                   		
	echo 'Login Completed'      
    		}         
		}
		
		stage('Push Image to Docker Hub') {         
      steps{      sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR -p ${DOCKERHUB_CREDENTIALS_PSW} ${DOCKERHUB_CREDENTIALS_REPOSITORY} '        
                   		
	echo 'Login Completed'                              
	sh 'docker push ramitr/ramiexam:1.0.0'         
	       echo 'Push Image Completed'       
      }           
    }
      }
      }
      