pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t robot-tests .'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh 'docker run --shm-size=1g -v ${WORKSPACE}/results:/app/results robot-tests robot --outputdir results tests/smoke_tests.robot'
            }
        }
    }
    
    post {
        always {
            robot outputPath: 'results/logs', passThreshold: 100, unstableThreshold: 75
            archiveArtifacts artifacts: 'results/**/*.*', allowEmptyArchive: true
        }
    }
}