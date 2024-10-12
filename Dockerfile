FROM archlinux:latest

# Install necessary packages
RUN pacman -Syu --noconfirm && \
  pacman -S --noconfirm \
  base-devel \
  curl \
  wget \
  git \
  rsync

RUN pacman -S --noconfirm \
  fish \
  qmk \
  yazi \
  fzf \
  ca-certificates \
  neovim 

RUN rm -rf /root/.config/nvim && \
  git clone https://github.com/LazyVim/starter /root/.config/nvim
RUN rm -rf ~/.config/nvim/.git

# Neovim init: not do well so far
RUN nvim +:q
# Set nvim as default editor so that yazi can open files in nvim
RUN fish -c 'set -Ux EDITOR nvim'

RUN pacman -S --noconfirm \
  python \
  python-pip \
  arm-none-eabi-gcc \
  dfu-util \
  avr-gcc \
  avr-libc \
  avrdude \
  usbutils

# Refer to keyball guide
# https://github.com/Yowkees/keyball/blob/main/qmk_firmware/keyboards/keyball/readme.md
# clone if keyball directory does not exist
WORKDIR /root
RUN [ -d ".keyball" ] || git clone https://github.com/Yowkees/keyball.git .keyball
# clone if qmk directory does not exist
# The following command noted in keyball guide produced an depth error.
# RUN [ -d "qmk" ] || git clone https://github.com/qmk/qmk_firmware.git --depth 1 --recurse-submodules --shallow-submodules -b 0.22.14 qmk
# So I changed the command to the following.
RUN [ -d "qmk" ] || git clone https://github.com/qmk/qmk_firmware.git --depth 1 -b 0.22.14 qmk
WORKDIR /root/qmk
RUN git submodule update --init --recursive --depth 1

WORKDIR /root/qmk
RUN qmk setup --yes

# Setting for udev
RUN cp /root/qmk/util/udev/50-qmk.rules /etc/udev/rules.d/

COPY . /root/opt
RUN chmod +x /root/opt/sync-to-host.fish

RUN cp -r /root/opt/Makefile /root/qmk/

# Clear cache
RUN pacman -Scc --noconfirm

RUN chsh -s /usr/bin/fish

ENTRYPOINT ["fish", "-c", "fish /root/opt/sync-to-host.fish; tail -f /dev/null"]
