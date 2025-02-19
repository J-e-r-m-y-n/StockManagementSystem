pipeline{
	agent any
	tools { 
        maven 'Maven 3.9.9' 
        jdk 'Java JDK 17' 
    }
	stages{
		stage("clean"){
			steps{
				echo "Start Clean"
				bat "mvn clean"
			}
		}
		stage("test"){
			steps{
				echo "Start Test"
				bat "mvn test"
			}
		}
		stage("build"){
			steps{
				echo "Start build"
				bat "mvn install -DskipTests"
			}
		}
		
		stage('Deploy to Tomcat') {
			steps {
				script {
					// Find the WAR file
            		//def warFile = findFiles(glob: 'target/*.war')[0]
            		def warFile = 'target\\StockManagementSystem.war'
            		//echo "Deploying WAR file: ${warFile.path}"
 
					// Tomcat Manager URL and credentials
					def tomcatUrl = 'http://localhost:8090/StockManagementSystem'
					def tomcatUser = 'tomcat'
					def tomcatPassword = 'password'
 
					// Deploy the WAR file using curl
					bat """
					curl -v -u ${tomcatUser}:${tomcatPassword} \
					-T ${warFile} \
					${tomcatUrl}/deploy?path=/StockManagementSystem
					"""
				}
			}
		}

	}
	
	post {
        success {
            echo 'Pipeline has been completed successfully.'
        }
        failure {
            echo 'Pipeline has failed - Please check the corresponding logs for more information.'
        }
    }

	
}