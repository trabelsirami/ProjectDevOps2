pipeline { 
    agent any
    environment {
			// This can be nexus3 or nexus2
        NEXUS_VERSION = "nexus3"
        // This can be http or https
        NEXUS_PROTOCOL = "http"
        // Where your Nexus is running
        NEXUS_URL = "172.20.2.128:8081"
        // Repository where we will upload the artifact
        NEXUS_REPOSITORY = "maven-releases"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "nexus"
           DOCKERHUB_CREDENTIALS= credentials('trrami') 
        
    }
     stages {
       stage ('Checkout GIT'){
                steps {
                    echo 'pulling... ';
                        git branch :'Rami',
                        url : 'https://github.com/momenguinoubi2/projectdevops.git';
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
        
             stage("publish to nexus") {
            steps {
                script {
                    // Read POM xml file using 'readMavenPom' step , this step 'readMavenPom' is included in: https://plugins.jenkins.io/pipeline-utility-steps
                    pom = readMavenPom file: "pom.xml";
                    // Find built artifact under target folder
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    // Print some info from the artifact found
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    // Extract the path from the File found
                    artifactPath = filesByGlob[0].path;
                    // Assign to a boolean response verifying If the artifact name exists
                    artifactExists = fileExists artifactPath;

                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";

                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                // Artifact generated such as .jar, .ear and .war files.
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],

                                // Lets upload the pom.xml file for additional information for Transitive dependencies
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );

                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }}   
        
         stage('Building our image') {
steps{
sh 'docker build -t ramitr/tpachat:1.0.0 .'
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
	sh 'docker push ramitr/tpachat:1.0.0'         
	       echo 'Push Image Completed'       
      }           
    }
    
    
         stage("docker compose")
          {
              steps{
                  sh'docker-compose up -d'
              }
          } 
       // stage("Unit Test"){
         //   steps {
           //     sh 'mvn test'
          //  }
        //}
        //stage("Packaging Project"){
          //  steps {
            //    sh 'mvn package'
            //}
        //}
    }
}