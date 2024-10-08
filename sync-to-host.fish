#!/usr/bin/fish
if not test -d /root/opt/keyball
    rsync -avz /root/.keyball/qmk_firmware/keyboards/keyball /root/opt
else
    echo "Directory '.keyball' already exists. Skipping rsync."
end

# make symlinks from keyball files to qmk keyboards
ln -s /root/opt/keyball /root/qmk/keyboards/keyball
