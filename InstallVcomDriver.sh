# Prepare driver files with compability modification
unzip Advantech-VCOM-Linux-Driver-2.3.5.zip -d ../drivers
scp adv_uart.c ../drivers/Advantech-VCOM-Linux-Driver-2.3.5/driver/adv_uart.c

# Prepare LIIS device mapping
scp advttyd.conf ../drivers/Advantech-VCOM-Linux-Driver-2.3.5/config/advttyd.conf

# Make driver
sudo apt-get install linux-headers-generic dkms openssl libssl-dev
cd ../drivers/Advantech-VCOM-Linux-Driver-2.3.5/
make

# Install driver
sudo mkdir /usr/local/advtty
sudo make install

# start the daemon
sudo advman -o insert
sudo advman -o start

# (auto)start advvcom service
sudo make install -C ./misc/systemd/
systemctl enable advvcom.service
systemctl start advvcom.service


echo "================================DONE=========================="
