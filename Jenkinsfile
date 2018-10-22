node {

    def app

    stage('Clone repository') {
        // Let's make sure we have the repository cloned to our workspace
        checkout scm
    }

    stage('Build image') {
        app = docker.build("robjahn/jmeter")
    }	
    stage('Build and Push Docker') {
	  
         docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
         } 
     }
}
