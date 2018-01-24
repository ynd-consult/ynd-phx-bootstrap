node ("jenkins-slave") {

  //update variables bellow
  //meaningful app name
  def app_name = "ynd_phx_bootstrap_app"

  //docker registry url
  def registry_url = "private_docker_registry"

  //docker registry password
  def registry_creds = "secret"

  //docker registry tag name
  def dcos_dr_tag = "private_docker_registry_hostname"

  //marathon url
  def marathon_url = "marathon_url"

  //marathon app id
  def marathon_id = "/yndphxbootstrap/app"

  //marathon credentials
  def dcos_creds = "SECRET_TOKEN"


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

    junit 'build/reports/junit/*.xml'
  }

  if(isOnDevelop()) {
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
