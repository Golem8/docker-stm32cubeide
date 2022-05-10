FROM ubuntu:18.04
LABEL Name=utatdocker Version=0.0.1

RUN apt-get -y update && apt-get -y install make unzip expect
RUN apt-get -y install git
# copy installer.sh.zip into opt
COPY installer.sh.zip /opt/
#unzip it into same directory
RUN unzip /opt/installer.sh.zip -d /opt
#rename it into something easier
RUN mv /opt/st-stm32cubeide_1.8.0_11526_20211125_0815_amd64.deb_bundle.sh /opt/stm32cubeide-installer.sh

COPY autoinstall.sh /opt/
RUN ["chmod", "+x", "/opt/stm32cubeide-installer.sh"]
RUN ["chmod", "+x", "/opt/autoinstall.sh"]

#run installer that autofills answers
RUN /opt/autoinstall.sh

#clean up installers
RUN ["rm",  "/opt/autoinstall.sh", "/opt/stm32cubeide-installer.sh", "/opt/installer.sh.zip"]

# make sure everything was fetched properly
RUN apt-get update --fix-missing
RUN ["git", "clone", "https://github.com/spacesys-finch/Firmware.git"]