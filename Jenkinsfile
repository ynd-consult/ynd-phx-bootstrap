node ("jenkins-slave") {

  //update variables bellow
  //meaningful app name
  def app_name = "ynd_phx_bootstrap_app"

  def registry_url
  def registry_creds
  def dcos_dr_tag
  def marathon_url
  def marathon_id
  def dcos_creds

  //docker registry url
  withCredentials([[$class: 'StringBinding', credentialsId: 'YND_PHX_REGISTRY_URL', variable: 'REGISTRY_URL']]) {
    registry_url = REGISTRY_URL
  }

  //docker registry password
  withCredentials([[$class: 'StringBinding', credentialsId: 'YND_PHX_REGISTRY_CREDS', variable: 'REGISTRY_CREDS']]) {
    registry_creds = REGISTRY_CREDS
  }

  //docker registry tag name
  withCredentials([[$class: 'StringBinding', credentialsId: 'YND_PHX_DCOS_DR', variable: 'TAG']]) {
    dcos_dr_tag = TAG
  }

  //marathon url
  withCredentials([[$class: 'StringBinding', credentialsId: 'YND_PHX_MARATHON_URL', variable: 'MARATHON_URL']]) {
    marathon_url = MARATHON_URL
  }


  //marathon app id
  withCredentials([[$class: 'StringBinding', credentialsId: 'YND_PHX_MARATHON_ID', variable: 'MARATHON_ID']]) {
    marathon_id = MARATHON_ID
  }

  //marathon credentials
  withCredentials([[$class: 'StringBinding', credentialsId: 'YND_PHX_DCOS_CREDS', variable: 'DCOS_CREDS']]) {
    dcos_creds = DCOS_CREDS
  }

  def deployment_result = "STARTED"
  def marathon_json = "marathon.json"

  stage('Checkout') {
    echo "Checkout"
    checkout scm
  }

  def tag = sh(returnStdout: true, script: "git rev-parse --short HEAD").trim()

  stage('Development build & Syntax Check') {
    sh("cp .env.example .env")
    sh("/usr/local/bin/docker-compose build")
    sh("/usr/local/bin/docker-compose run --rm app mix do deps.get, credo --strict")
  }

  stage('Unit Tests') {
    sh("/usr/local/bin/docker-compose run --rm app mix test")
    sh("/usr/local/bin/docker-compose down")

    junit 'build/report/junit/*.xml'
  }

  if(isOnDevelop()) {
    stage("Setup marathon files") {
      withCredentials([file(credentialsId: 'YND_PHX_MARATHON_JSON', variable: 'MARATHON_JSON')]) {
        withCredentials([file(credentialsId: 'YND_PHX_MARATHON_DB_JSON', variable: 'MARATHON_DB_JSON')]) {
          sh("cp \"$MARATHON_JSON\" ./marathon.json")
          sh("cp \"$MARATHON_DB_JSON\" ./marathon-db.json")
        }
      }
    }

    stage("Production build") {
      image = docker.build("${app_name}:${tag}", "-f rel/Dockerfile .")
    }

    stage("Promote") {
      docker.withRegistry("${registry_url}","${registry_creds}") {
        image.push("${tag}")
      }
    }

    stage("Deployment") {
      marathon credentialsId: "${dcos_creds}", docker: "${dcos_dr_tag}/${app_name}:${tag}", filename: "${marathon_json}", forceUpdate: true, id: "${marathon_id}", url: "${marathon_url}"
    }
  }

  stage('Dev Tests') {
    echo "Test Dev"
  }
}

def isOnDevelop() {
  return !env.BRANCH_NAME || env.BRANCH_NAME == "develop";
}
