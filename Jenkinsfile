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
		
		stage("sonar") {
            steps {
                script {
					def scannerHome = tool 'sonarqube-scanner'

                    // Prepare SonarQube environment
                    def sonarProperties = """
                        sonar.projectKey=maven-project-jenkins-lab2
                        sonar.projectName=maven-project-jenkins-lab2-name
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
                    	bat "${scannerHome}/bin/sonar-scanner -Dproject.settings=sonar-project.properties"
                	}
                }
            }
        }
			
	}
}