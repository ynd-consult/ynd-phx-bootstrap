<h1 align="center">YndPhxBootstrap</h1>

<div align="center">
  <strong>Production ready, maintainable, fast & scalable template for Elixir Phoenix api server</strong>
</div>

<br />

<div align="center">
  <!-- Build Status -->
  <a href="https://jenkins.io/">
    <img src="https://img.shields.io/jenkins/s/https/jenkins.qa.ubuntu.com/view/Precise/view/All%20Precise/job/precise-desktop-amd64_default.svg"
      alt="Build Status" />
  </a>
</div>

<div align="center">
  <h3>
    <a href="https://ynd.co">
      YND
    </a>
    <span> | </span>
    <a href="http://phoenixframework.org/">
      Elixir Phoenix
    </a>
    <span> | </span>
    <a href="https://dcos.io/">
      DC/OS
    </a>
    <span> | </span>
    <a href="https://mesosphere.github.io/marathon/">
      Marathon
    </a>
    <span> | </span>
    <a href="https://www.docker.com/">
      Docker
    </a>
    <span> | </span>
    <a href="https://jenkins.io/">
      Jenkins
    </a>
    <span> | </span>
    <a href="https://sentry.io/">
      Sentry
    </a>
    <span> | </span>
    <a href="https://www.graylog.org/">
      Graylog
    </a>
  </h3>
</div>

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Support](#support)
- [License](#license)

## Features
- __DC/OS cluster:__ cluster built using Mesosphere DC/OS 1.10
- __load balancing:__ load balancing and autoscaling is handled by marathon-lb
- __CI:__ continuous delivery with Jenkins
- __log management:__ Graylog for log aggregation
- __error tracking:__ manage errors with Sentry
- __development setup:__ start coding within minutes - seamless developer experience thanks to Docker & docker-compose

## Prerequisites
- DC/OS cluster running with marathon-lb plugin enabled
- Jenkins up and running
- Sentry up and running
- Graylog up and running
- Docker registry up and running (or one could use https://hub.docker.com/)
- Docker & docker-compose installed on developer host machine


## Setup
### Jenkinsfile
Setting up the production environment requires some credentials in jenkins to be setup first. Please check the `Jenkinsfile` included in repo.
Required changes

* `app_name` give a meaningful name for the app
* `registry_creds` docker registry credentials
* `dcos_dr_tag` first part of docker image tag if you are pushing to private docker registry it should point to hostname of your private docker registry
* `marathon_url` marathon service url
* `marathon_id` marathon application name identifier
* `dcos_creds` marathon credentials

### `marathon.json` and `marathon-db.json`
We use jenkins config file provider plugin to provide ad hoc build configuration for orchestration platform. We have provided two example files (`marathon.json.example`, `marathon-db.json.example`) to ilustrate how the setup might look like.
Excerpt of `marathon.json` configuration options

* `id` it should match the `marathon_id` from Jenknisfile
* `container.docker.image` tag name of docker image you wish to pull from docker registry
* `container.portMappings.name` name of your app in DC/OS
* `env` those env variables are accessible in your container and used by binary elixir phoenix release. You probably want to alter all of the variables here except `MIX_ENV` and `PORT`. `SENTRY_ENDPOINT` is also know as sentry dsn.
* `labels.HAPROXY_0_VHOST`

Excerpt of `marathon-db.json` configuration options

* `id` identifier of the postgresql database service in DC/OS
* `container.portMappings.name` name of postgresql database service in DC/OS
* `env.POSTGRES_USER` this env variable should match `env.DB_REPO_USER` in `marathon.json` file
* `env.POSTGRES_PASSWORD` this env variable should match `env.DB_REPO_PASSWORD` in `marathon.json** file

## Usage
### Development
To run commands in development you need to have working `.env` file
```bash
$ cp .env.example .env
```

Install the dependencies and compile
```bash
$ docker-compose run --rm app mix do deps.get, compile
```

Start the server on port 4000
```bash
$ docker-compose up
```

Run tests
```bash
$ docker-compose run --rm app mix test
```

## Support
Contact us at [hello@ynd.co](mailto:hello@ynd.co)

## License
[MIT](https://tldrlegal.com/license/mit-license)
