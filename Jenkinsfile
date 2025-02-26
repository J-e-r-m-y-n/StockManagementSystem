pipeline{
	// This is a Declarative Pipeline
	// Allows the job to run on any available agent or machine that is connected
	agent any
	// Auto-installs the tools required for this Pipeline to run: Maven 3.9.9 and Java JDK 17
	tools { 
        maven 'Maven 3.9.9' 
        jdk 'Java JDK 17' 
    }
    // The list of stages in this Pipeline
	stages{
		// The name of this stage
		stage("clean"){
			// The steps in this stage
			steps{
				// Text to display at the start of this Stage
				echo "Start Clean"
				// Deletes the target directory, which contains all the compiled files and build artifacts from previous builds
				bat "mvn clean" 
			}
		}
		stage("test"){
			steps{
				// Text to display at the start of this stage
				echo "Start Test"
				// Compiles the code and runs any unit tests
				bat "mvn test"
			}
		}
		stage("build"){
			steps{
				// Text to display at the start of this stage
				echo "Start Build"
				// Compiles, test, package and installs the project
				// "-DskipTests" will skip the test step
				bat "mvn install -DskipTests"
			}
		}

		stage("sonar") {
            steps {
				// Script to Prepare SonarQube environment
				// https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/analysis-parameters/
                script {
                    // Defining parameters for sonarProperties file
                    def sonarProperties = """
                        sonar.projectKey=StockManagementSystem
                        sonar.projectName=StockManagementSystem-name
                        sonar.projectVersion=1.0
                        sonar.sources=src/main
                        sonar.sourceEncoding=UTF-8
                        sonar.language=java
                        
                        sonar.tests=src/test
                        sonar.junit.reportsPath=target/surefire-reports
                        sonar.surefire.reportsPath=target/surefire-reports
                        sonar.jacoco.reportPath=target/jacoco.exec
                        
                        sonar.java.binaries=target/classes
                        sonar.java.coveragePlugin=jacoco
                    """

                    // Create sonar-project.properties file
                    writeFile file: 'sonar-project.properties', text: sonarProperties

                    // Run SonarQube scan using the properties file
                    withSonarQubeEnv('sonarqube_server') {
                    	bat "mvn sonar:sonar"
                	}
                }
             }
 }
		
stage('Deploy to Tomcat') {
			steps {
				script {
					// Find the WAR file
            		// def warFile = findFiles(glob: 'target/*.war')[0]
            		def warFile = 'target\\StockManagementSystem.war'
            		// echo "Deploying WAR file: ${warFile.path}"
 
					// Tomcat Manager URL and credentials
					def tomcatUrl = 'http://localhost:8090/manager/text'
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
			// Text to display when Pipeline has been completed successfully
            echo 'Pipeline has been completed successfully.'
        }
        failure {
			// Text to display when Pipeline has been unsuccessful
            echo 'Pipeline has failed. Please check the corresponding logs for more information.'
        }
        
        always {
			// Creates and sends email notification in the following format
            mail to: 'jermyn.school@gmail.com',
                 subject: "Email Notification - Jenkins Build Status: ${currentBuild.fullDisplayName}",
                 body: """\
                 Build Status: ${currentBuild.currentResult}
                 Project: ${env.JOB_NAME}
                 Build Number: ${env.BUILD_NUMBER}
                 Build URL: ${env.BUILD_URL}
                 """
        }
    }

	
}