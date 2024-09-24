
###
### BASE CONFIGURATION
###
FROM ubuntu:24.04 AS base

# update, upgrade & install some dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install zip unzip sudo curl wget iputils-ping fish git python3 python3-virtualenv python3-venv -y

# add user
RUN userdel ubuntu
RUN useradd -m -s /bin/fish dev --uid 1000
RUN usermod -aG sudo dev
RUN bash -c "echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"

# create the workspace directory
RUN mkdir /workspace



###
### FISH
###
FROM base AS fish-setup
RUN mkdir -p /home/dev/.config/fish
COPY fish/config.fish /home/dev/.config/fish


 
###
### LANGUAGES
###
FROM fish-setup AS languages

# instll golan
RUN curl -LO https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz

# install gopls
USER dev
RUN fish -c "go install golang.org/x/tools/gopls@latest"
USER root

# install corretto 21
RUN mkdir -p /usr/opt/java/correto-21
RUN curl -LO https://corretto.aws/downloads/latest/amazon-corretto-21-x64-linux-jdk.tar.gz && tar -C /usr/opt/java/correto-21 -xzf amazon-corretto-21-x64-linux-jdk.tar.gz
USER root



### 
### NEOVIM
###
FROM languages AS neovim
# install nvim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
RUN tar -C /opt -xzf nvim-linux64.tar.gz
USER root



####
### PERMS FIX
###
FROM neovim AS final
RUN chown -R dev /home/dev/.config
RUN chown -R dev /workspace



###
### ENTRYPOINT
###
USER dev
ENV HOME="/home/dev"
WORKDIR /workspace
CMD ["/bin/fish"]
