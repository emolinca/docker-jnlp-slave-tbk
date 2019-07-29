/* NOTE: this Pipeline mainly aims at catching mistakes (wrongly formed Dockerfile, etc.)
 * This Pipeline is *not* used for actual image publishing.
 * This is currently handled through Automated Builds using standard Docker Hub feature
*/
pipeline {
    agent { label 'linux' }

    options {
        timeout(time: 2, unit: 'MINUTES')
        buildDiscarder(logRotator(daysToKeepStr: '10'))
        timestamps()
    }

    triggers {
        pollSCM('H/24 * * * *') // once a day in case some hooks are missed
    }

    stages {
        stage('Build Docker Image') {
            steps {
                deleteDir()
                checkout scm
                echo "Update package index"
yum update

echo "Install Docker engine"
yum update -y
yum install docker -y
usermod -aG docker ec2-user
service docker start

echo "Install git"
yum install -y git

echo "Install Maven"
yum install maven

echo "Install Kiuwan"

echo $JAVA_HOME
wget https://www.kiuwan.com/pub/analyzer/KiuwanLocalAnalyzer.zip -P .
mkdir /opt/kiuwan
unzip KiuwanLocalAnalyzer.zip -d /opt/kiuwan
chmod +x /opt/kiuwan/KiuwanLocalAnalyzer/bin/*.sh
export AGENT_HOME=/opt/kiuwan/KiuwanLocalAnalyzer
echo $AGENT_HOME

#git clone https://github.com/gtoledoe/kiuwan_config.git
git clone https://github.com/emolinca/kiuwan.git
cp kiuwan_config/pipe-analisis.properties $AGENT_HOME/conf/
chown -R jenkins:jenkins /opt

#$AGENT_HOME/bin/agent.sh -n ${CIRCLE_PROJECT_REPONAME} -s ${HOME}/repo

                sh 'make build'
            }
        }
    }
}

// vim: ft=groovy
