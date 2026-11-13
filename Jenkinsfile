pipeline {
    agent any
    options { skipDefaultCheckout(true) }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Validate') {
            steps { sh 'sh scripts/validate.sh' }
        }
        stage('Build') {
            steps { sh 'sh scripts/build.sh' }
        }
        stage('Deploy') {
            steps {
                sh '''set -eu
                    test -d /site
                    cp dist/index.html /site/index.html
                    cmp dist/index.html /site/index.html
                '''
            }
        }
        stage('Verify website') {
            steps {
                sh '''set -eu
                    count=$(awk 'END{print NR-1}' records.csv)
                    curl --fail --silent --show-error http://records-web/ > deployed.html
                    grep -F "Total employees: $count" deployed.html
                    echo "Deployed website verified: $count records"
                '''
            }
        }
    }
    post {
        success { echo 'SUCCESS: CSV checked, webpage built and deployed.' }
        failure { echo 'FAILED: Open Console Output to find the error.' }
    }
}
