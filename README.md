# qmk-docker-keyball

This repository provides a Docker workflow that allows you to build [keyball 🎱](https://github.com/Yowkees/keyball) firmware based on [qmk-firmware](https://github.com/qmk/qmk_firmware) without having to install any dependencies on your local machine. This enables you to build keyball firmware on any platform that supports Docker, including Windows, macOS, and Linux.

## ✨ Features

- **Cross-platform 🖥️**: Build keyball 39, 44, and 61 firmware on any platform that supports Docker.
- **Dependency-free 🆓**: No need to install any dependencies on your local machine.
- **Automated 🤖**: Automatically download the required qmk-firmware and keyball repositories.
- **Customizable 💪**: Customize your keymap from your host machine.

## ⚡️ Requirements

- [Docker](https://docs.docker.com/get-docker/)

## 🚀 Quick Start

<details>

- Clone this repository:

    ```bash
    git clone xxx
    ```

- Build the Docker image:

    ```bash
    docker build up -d --build
    ```

    It takes a while to build. If you have the built image, you can use `docker-compose up -d` to start the container.

- Enter the Docker container with fish shell:

    ```bash
    docker-compose exec qmk-docker-keyball fish
    ```

- Build the keyball firmware:

    ```bash
    make SKIP_GIT=yes keyball/keyball39:via
    ```

    After this compile is done, you can find *.hex file in the build folder under following path:

  - `docker`: /root/opt/build
  - `host`: ./build

- Exit the Docker container and clean up:

    Exit the Docker container:

    ```bash
    exit
    ```

    Stop and remove the Docker container:

    ```bash
    docker-compose down
    ```

- Flash the firmware to your keyball:
  - Use [QMK Toolbox](https://qmk.fm/toolbox)
  - Use [Pro Micro Web Updater](https://sekigon-gonnoc.github.io/promicro-web-updater/index.html)

  *.hex file is located in the `build` directory.

</details>

## 📝 Customizing Your Keymap

You can customize your keymap from your host machine. The keymap is located in the `keyball/keyball39/keymaps/default` directory. You can modify the `keymap.c` file to customize your keymap.

<details>

Execute the following commands in your host machine.

- Move to the keymap direcotyr:

    ```bash
    cd keyball/keyball39/keymaps
    ```

- Copy from template:

   ```bash
    cp -r via custom
    ```

- Edit the keymap
- Compile the firmware in the Docker container

    ```bash
    docker-compose up -d
    docker-compose exec qmk-docker-keyball fish
    make SKIP_GIT=yes keyball/keyball39:custom
    exit
    docker-compose down
    ```

- Flash the firmware to your keyball:

  Refer to the previous section.

</details>

## 📚 References

1. [QMK Firmware](https://github.com/qmk/qmk_firmware)
2. [keyball](https://github.com/Yowkees/keyball)
3. [keyball qmk_firmware](https://github.com/Yowkees/keyball/blob/main/qmk_firmware/keyboards/keyball/readme.md)
