FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  ansible sudo curl git zsh rsync vim \
  && apt-get clean

ARG UID=1000
ARG GID=1000

RUN userdel -f $(getent passwd $UID | cut -d: -f1) 2>/dev/null || true && \
  groupdel $(getent group $GID | cut -d: -f1) 2>/dev/null || true && \
  groupadd -g $GID samyn && \
  useradd -l -m -u $UID -g $GID -s /usr/bin/zsh samyn && \
  echo "samyn ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER samyn

WORKDIR /install_dir

COPY . /install_dir/

RUN EXTRA_TAGS=zsh,tmux ./scripts/install-nvim.sh

COPY docker/.zshrc /home/samyn/

USER root
RUN apt-get purge -y ansible \
  && apt-get autoremove -y
RUN rm -rf /install_dir /var/lib/apt/lists/* /tmp/*
USER samyn


ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

WORKDIR /app

CMD ["sleep", "infinity"]
