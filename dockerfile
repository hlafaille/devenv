FROM ubuntu:24.04 AS install

# config options
ARG USER_NAME=hlafaille

###
### BASE CONFIGURATION
###
# update, upgrade & install some dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install zip unzip sudo curl wget iputils-ping fish git python3 python3-virtualenv python3-venv -y

# add user
RUN useradd -m -s /bin/fish ${USER_NAME}
RUN usermod -aG sudo ${USER_NAME}
RUN bash -c "echo '${USER_NAME} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"

###
### FISH
###
RUN mkdir -p /home/${USER_NAME}/.config/fish
COPY fish/config.fish /home/${USER_NAME}/.config/fish
 
###
### LANGUAGES
###
# install golang
RUN curl -LO https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz

# install gopls
USER ${USER_NAME}
RUN fish -c "go install golang.org/x/tools/gopls@latest"
USER root

# install corretto 21
RUN mkdir -p /usr/opt/java/correto-21
RUN curl -LO https://corretto.aws/downloads/latest/amazon-corretto-21-x64-linux-jdk.tar.gz && tar -C /usr/opt/java/correto-21 -xzf amazon-corretto-21-x64-linux-jdk.tar.gz
USER root

### 
### NEOVIM
###
# install nvim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
RUN tar -C /opt -xzf nvim-linux64.tar.gz
COPY nvim /home/${USER_NAME}/.config/nvim
USER root

####
### PERMS FIX
###
RUN chown -R ${USER_NAME} /home/${USER_NAME}/.config

###
### ENTRYPOINT
###
USER ${USER_NAME}
ENV HOME="/home/${USER_NAME}"
WORKDIR /workspace
CMD ["/bin/fish"]
