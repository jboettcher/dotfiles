FROM ubuntu:23.04

# Install core packages
RUN apt-get update -qq \
    && apt-get install -y \
        sudo openssh-server tmux neovim git curl locales tig exuberant-ctags \
        build-essential binutils make cmake clang clang-format lld ninja-build ccache bison gdb lldb libsystemd-dev \
        linux-tools-common linux-tools-generic \
        python3-pip \
        htop golang \
        unzip \
        fd-find \
        software-properties-common \
    && ln -fs /usr/lib/linux-tools/*/perf /usr/bin/perf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install dev packages
RUN apt-get update -qq \
    && apt-get install -y \
        llvm libasan5 libboost-all-dev libc-dev libclang-dev libjemalloc-dev libssl-dev libtinfo-dev \
        libpthread-stubs0-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install rr debugger
RUN cd /tmp \
    && curl -L -o rr.deb https://github.com/mozilla/rr/releases/download/5.3.0/rr-5.3.0-Linux-x86_64.deb \
    && dpkg -i rr.deb \
    && rm -rf rr.deb

# Configure locale
RUN locale-gen en_US.UTF-8 \
    && echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Configure SSH server
#RUN mkdir /var/run/sshd \
#    && sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
#    && sed -i 's/session\s*required\s*pam_loginuid.so/session optional pam_loginuid.so/g' /etc/pam.d/sshd

# Install neovim
RUN apt-get update -y \
    && apt-get install -y \
       neovim \
       nodejs \
       npm


RUN ["apt-get", "install", "-y", "zsh"]

# Switch to caravan user
RUN useradd -ms /usr/bin/zsh caravan \
    && usermod -aG sudo caravan
USER caravan
WORKDIR /home/caravan
SHELL ["/usr/bin/zsh", "-c"]

# Install dotfiles
COPY --chown=caravan:caravan . /home/caravan/.dotfiles/
RUN cd .dotfiles \
    && make install-ohmyzsh \
    && make install-config \
    && make install-fzf install-ccls  \
    && chmod +x ./entrypoint.sh

# Setup neovim
RUN cd ~/.dotfiles && make install-vim-plug \
    && cd ~/.dotfiles && make install-monokai \
    && nvim --headless +UpdateRemotePlugins +PlugInstall +qall!

# Configure SSH daemon
USER root
EXPOSE 22
ENTRYPOINT ["/home/caravan/.dotfiles/caravan/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
