pipeline {
    agent { docker { image 'ruby' } }
    stages {
        stage('test') {
            steps {
                sh 'ruby --version'
                sh 'bundle exec rspec'
            }
        }
    }
    post {
      success {
        echo 'Successful'
      }
      failure {
        echo 'Failure'
      }
    }
}
