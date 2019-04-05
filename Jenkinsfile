node {

    def myRepo = checkout scm
    def gitCommit = myRepo.GIT_COMMIT
    def gitBranch = myRepo.GIT_BRANCH

    sh "git rev-parse --short HEAD > commit-id"
    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "hello-kenzan"
    registryHost = "127.0.0.1:30400/"
    imageName = "${registryHost}${appName}:${tag}"

    env.DOCKER_API_VERSION="1.23"
    env.BUILDIMG=imageName
    env.BUILD_TAG=tag
    env.GIT_COMMIT=gitCommit
    env.GIT_BRANCH=gitBranch

    stage('Build'){
        sh "docker build -t ${imageName} -f applications/hello-kenzan/Dockerfile applications/hello-kenzan"
    }

    stage('Push'){
        sh "docker push ${imageName}"
    }

    stage('Deploy'){
        kubernetesDeploy configs: "applications/${appName}/k8s/*.yaml", kubeconfigId: 'kenzan_kubeconfig', enableConfigSubstitution: true
    }
}