
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
