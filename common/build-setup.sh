date > /etc/vagrant_provisioned_at
milestone=$1
update_version=$2
build_number=$3

printf "milestone: %s update_version: %s build_number: %s" $milestone $update_version $build_number

echo Install Mercurial
yum -y install mercurial

echo Install compilers, external libraries and header files for developer packages 
yum -y groupinstall "Development Tools"

echo Install boot JDK
yum -y install java-1.8.0-openjdk-devel

echo Install X11
yum -y install libXtst-devel libXt-devel libXrender-devel libXi-devel

echo Install Common UNIX Printing System
yum -y install cups-devel

echo Install FreeType
yum -y install freetype-devel

echo Install Advanced Linux Sound Architecture
yum -y install alsa-lib-devel

echo Install Fontconfig
yum -y install fontconfig-devel

cd /common

echo Getting the jdk8u forest
hg clone http://hg.openjdk.java.net/jdk8u/jdk8u

echo Switching tags to jdk8u$update_version-$build_number
hg up jdk8u$update_version-$build_number

cd jdk8u

echo Get the source code
bash get_source.sh

echo Call configure with boot JDK location
echo Calling configure 
bash configure --with-boot-jdk=/usr/lib/jvm/java-1.8.0 --with-milestone=$milestone --with-update-version=$update_version --with-build-number=$build_number

echo Making all and profiles
make all
make profiles

echo Compressing compact1
cd /common/jdk8u/build/linux-x86_64-normal-server-release/images/j2re-compact1-image
tar zcvf /common/jre-8u$update_version-$build_number-compact1-linux-x64.tar.gz * 

echo Compressing compact2
cd /common/jdk8u/build/linux-x86_64-normal-server-release/images/j2re-compact2-image
tar zcvf /common/jre-8u$update_version-$build_number-compact2-linux-x64.tar.gz * 

echo Compressing compact3
cd /common/jdk8u/build/linux-x86_64-normal-server-release/images/j2re-compact3-image
tar zcvf /common/jre-8u$update_version-$build_number-compact3-linux-x64.tar.gz * 

echo Compressing full 
cd /common/jdk8u/build/linux-x86_64-normal-server-release/images/j2re-image
tar zcvf /common/jre-8u$update_version-$build_number-full-linux-x64.tar.gz *

echo Finished building OpenJDK.  Images will be in /common 

