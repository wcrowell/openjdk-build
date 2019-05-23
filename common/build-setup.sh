date > /etc/vagrant_provisioned_at

# Install wget and OpenJDK 

# Install Mercurial
yum -y install mercurial

# Install compilers, external libraries and header files for developer packages 
yum -y groupinstall "Development Tools"

# Install boot JDK
yum -y install java-1.8.0-openjdk-devel

# Install X11
yum -y install libXtst-devel libXt-devel libXrender-devel libXi-devel

# Install Common UNIX Printing System
yum -y install cups-devel

# Install FreeType
yum -y install freetype-devel

# Install Advanced Linux Sound Architecture
yum -y install alsa-lib-devel

# Install Fontconfig
yum -y install fontconfig-devel

cd /common

# Get the jdk8u forest
hg clone http://hg.openjdk.java.net/jdk8u/jdk8u

cd jdk8u

# Get the source code
bash get_source.sh

# Call configure with boot JDK location
bash configure --with-boot-jdk=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.el7_6.x86_64

make images

echo Finished building OpenJDK.  Image will be in /common/jdk8u/build/linux-x86_64-normal-server-release/images/j2re-image 

