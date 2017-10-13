locale-gen de_CH.utf8
echo "Europe/Zurich" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins
apt-get install -y zip
wget -q https://services.gradle.org/distributions/gradle-3.5.1-bin.zip
mkdir -p /opt/gradle
unzip -d /opt/gradle -u gradle-3.5.1-bin.zip
