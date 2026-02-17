FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  ansible sudo curl git zsh rsync vim python3-venv \
  && apt-get clean

ARG USER_NAME=samyn
ARG USER_HOME=/home/${USER_NAME}
ARG UID=1000
ARG GID=1000

RUN userdel -f $(getent passwd $UID | cut -d: -f1) 2>/dev/null || true && \
  groupdel $(getent group $GID | cut -d: -f1) 2>/dev/null || true && \
  groupadd -g $GID ${USER_NAME} && \
  useradd -l -m -u $UID -g $GID -s /usr/bin/zsh ${USER_NAME} && \
  echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER_NAME}

WORKDIR /install_dir

COPY . /install_dir/

RUN EXTRA_TAGS=golang,nodejs,zsh,tmux ./scripts/install-nvim.sh


ENV GOROOT=/usr/local/go \
  GOPATH=${USER_HOME}/go \
  PATH=/usr/local/go/bin:${USER_HOME}/go/bin:${USER_HOME}/.local/bin:${USER_HOME}/.local/share/nvim/mason/bin:$PATH

COPY --chown=${USER_NAME}:${USER_NAME} docker/.zshrc /home/${USER_NAME}/

USER root
# RUN npm install -g tree-sitter-cli
RUN apt-get purge -y ansible \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /install_dir /var/lib/apt/lists/* /tmp/* \
  ${USER_HOME}/.cache/* $GOPATH/pkg $GOPATH/src
USER ${USER_NAME}

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

WORKDIR /app

CMD ["sleep", "infinity"]
