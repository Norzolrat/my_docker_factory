FROM debian:stable

# ENV NEW_USER=username
# ENV NEW_PASSWORD=password

RUN apt-get update && apt-get -y install apt-utils openssh-server net-tools curl vim zsh sudo git 

RUN useradd -m -s /usr/bin/zsh "${NEW_USER}"
RUN echo "${NEW_USER}:${NEW_PASSWORD}" | chpasswd
RUN echo "${NEW_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/11-userrules
RUN chmod 400 /etc/sudoers.d/11-userrules

RUN mkdir /run/sshd

USER "${NEW_USER}"
WORKDIR /home/"${NEW_USER}"
RUN mkdir data
COPY .zshrc .

CMD ["sudo","/usr/sbin/sshd", "-D"]

# Before run the docker :
# 
# docker build -t myimage .
# docker run -d -e NEW_USER=myuser -e NEW_PASSWORD=mypassword -v "$(pwd)/data:/home/myuser/data" --network bridge --name mycontainer --hostname myhostname myimage
