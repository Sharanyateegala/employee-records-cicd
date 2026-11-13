EMPLOYEE RECORDS CI/CD DEMO (50 INITIAL RECORDS)
================================================
This is fictional sample employee data. CSV opens directly in Excel.

This project expects:
- Docker network named records-net
- Docker volume named records-site mounted at /site in Jenkins
- Nginx container named records-web mounted to same volume (read-only)
- Jenkins job: Pipeline script from SCM, Git, branch */main, script Jenkinsfile

Pipeline stages: Checkout, Validate, Build HTML, Deploy into shared volume, Verify HTTP webpage.

Add record 51 in Excel to records.csv:
151,Kiran,DevOps,Austin
Save as CSV UTF-8; commit and push to GitHub; click Build Now in Jenkins again.
View http://localhost:8081 and check Total employees changes from 50 to 51.

NOTES:
- Jenkins does NOT need access to Docker Engine to deploy a static page to an existing Nginx container via a shared Docker volume.
- Keep Docker Desktop running and both containers running.
- This is for local learning, not production deployment.
