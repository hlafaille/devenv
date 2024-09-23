FROM ubuntu:24.04 AS install

# config options
ARG USER_NAME=hlafaille

###
### BASE CONFIGURATION
###
# update, upgrade & install some dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install zip unzip sudo curl wget iputils-ping fish git -y

# add user
RUN useradd -m -s /bin/fish ${USER_NAME}
RUN usermod -aG sudo ${USER_NAME}
RUN bash -c "echo '${USER_NAME} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"

###
### LANGUAGES
###
# install golang
RUN curl -LO https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz
USER ${USER_NAME}
RUN mkdir -p /home/${USER_NAME}/.config/fish
RUN echo 'set -gx PATH /usr/local/go/bin $PATH' >> ~/.config/fish/config.fish
USER root

# install corretto 21
RUN mkdir -p /usr/opt/java/correto-21
RUN curl -LO https://corretto.aws/downloads/latest/amazon-corretto-21-x64-linux-jdk.tar.gz && tar -C /usr/opt/java/correto-21 -xzf amazon-corretto-21-x64-linux-jdk.tar.gz
USER ${USER_NAME}
RUN echo 'set -gx PATH /usr/opt/java/correto-21/amazon-corretto-21.0.4.7.1-linux-x64/bin $PATH' >> ~/.config/fish/config.fish
USER root

# install nodejs
USER ${USER_NAME}
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
USER root

### 
### NEOVIM
###
# install nvim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
RUN tar -C /opt -xzf nvim-linux64.tar.gz
USER ${USER_NAME}
RUN mkdir -p /home/${USER_NAME}/.config/fish
RUN echo 'set -gx PATH /opt/nvim-linux64/bin  $PATH' >> ~/.config/fish/config.fish
COPY nvim /home/${USER_NAME}/.config/nvim
USER root
RUN chown -R ${USER_NAME} /home/${USER_NAME}/.config

###
### entrypoint
###
USER ${USER_NAME}
ENV HOME="/home/${USER_NAME}"
WORKDIR /home/${USER_NAME}
CMD ["/bin/fish"]
