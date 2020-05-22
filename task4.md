###1.
sudo su
useradd dev1 -d /home/dev1 -m -s /bin/bash -u 2010 -p $(openssl passwd '123')
visudo -f /etc/sudoers.d/dev1
```
	dev1 ALL = (ALL:ALL) ALL
```

###2. Создать группу developer, 
groupadd -g 4000 developers

несколько пользователей, входящих в эту группу. 
useradd dev2 -s /bin/bash -u 2020 -p $(openssl passwd '123') -G developers
useradd dev3 -s /bin/bash -u 2030 -p $(openssl passwd '123') -G developers
usermod -aG developers dev1

Создать директорию для совместной работы. 
mkdir /usr/developers

Сделать так, чтобы созданные одними пользователями файлы могли изменять другие пользователи этой группы. 
chmod 2775 /usr/developers
chown root:developers /usr/developers
ls -la /usr/developers


Создать в директории для совместной работы поддиректорию для обмена файлами, но чтобы удалять файлы могли только их создатели.
mkdir /usr/developers/share
sudo chmod 3775 /usr/developers/share


###3. 
скрипт в файле task4.sh

sudo chown root:root ./task4.sh
sudo chmod 6775 ./task4.sh
