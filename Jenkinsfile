#!groovy
def tryStep(String message, Closure block, Closure tearDown = null) {
    try {
        block();
    }
    catch (Throwable t) {
        slackSend message: "${env.JOB_NAME}: ${message} failure ${env.BUILD_URL}", channel: '#ci-channel', color: 'danger'
        throw t;
    }
    finally {
        if (tearDown) {
            tearDown();
        }
    }
}
node {
    stage("Checkout") {
        checkout scm
    }
    stage("Build image") {
        tryStep "build", {
            def image = docker.build("docker-registry.secure.amsterdam.nl/irma/irma-backend:${env.BUILD_NUMBER}")
            image.push()
        }
    }
}
String BRANCH = "${env.BRANCH_NAME}"
if (BRANCH == "develop") {
    node {
        stage('Push acceptance image') {
            tryStep "image tagging", {
                def image = docker.image("docker-registry.secure.amsterdam.nl/irma/irma-backend:${env.BUILD_NUMBER}")
                image.pull()
                image.push("acceptance")
            }
        }
    }
    node {
        stage("Deploy to ACC") {
            tryStep "deployment", {
                build job: 'Subtask_Openstack_Playbook',
                    parameters: [
                            [$class: 'StringParameterValue', name: 'INVENTORY', value: 'acceptance'],
                            [$class: 'StringParameterValue', name: 'PLAYBOOK', value: 'deploy.yml'],
                            [$class: 'StringParameterValue', name: 'PLAYBOOKPARAMS', value: "-e cmdb_id=app_irma-backend"]
                    ]
            }
        }
    }
}

if (BRANCH == "master") {
    stage('Waiting for approval') {
        slackSend channel: '#ci-channel', color: 'warning', message: 'irma-backend is waiting for Production Release - please confirm'
        input "Deploy to Production?"
    }
    node {
        stage('Push production image') {
        tryStep "image tagging", {
            def image = docker.image("docker-registry.secure.amsterdam.nl/irma/irma-backend:${env.BUILD_NUMBER}")
                image.pull()
                image.push("production")
                image.push("latest")
            }
        }
    }
    node {
        stage("Deploy") {
            tryStep "deployment", {
                build job: 'Subtask_Openstack_Playbook',
                parameters: [
                    [$class: 'StringParameterValue', name: 'INVENTORY', value: 'production'],
                    [$class: 'StringParameterValue', name: 'PLAYBOOK', value: 'deploy.yml'],
                    [$class: 'StringParameterValue', name: 'PLAYBOOKPARAMS', value: "-e cmdb_id=app_irma-backend"]
                ]
            }
        }
    }
}

