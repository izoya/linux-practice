3. 
- самостоятельно изучить, что такое бит SetGID. Указать сценарий его использования (как на практике применяют??)
setgid дает возможность программам, запущенным пользователями, менять файлы, которые напрямую этим пользователям не доступны. Отображается в правах доступа как буква s на месте x. 
Устанавливается командой chmod g+s filename. 
Установленный для директории, этот аттрибут дает всем вновь создаваемым в этой директории файлам и папкам такую же группу-владельца, как у родительской директории. Удобно для работы в совместно используемых папках, чтобы все пользователи имели доступ к файлам независимо от их создателя.



- самостоятельно посмотреть, как изменить владельца пользователя и группу у файла (команда chmod)
chown  user:group filename 


- используйте эти знания, чтобы решить проблему пермиссий во время выполнения задания 4. Укажите, как именно решили проблему.
chmod g+s /opt/node


4. Установка node из исходников
- склонировать репозиторий https://github.com/nodejs/node в /opt/.
sudo chmod o+w /opt/
git clone git@github.com:nodejs/node.git /opt/node

- установить компилятор и необходимые зависимости, как написано в https://github.com/nodejs/node/blob/master/BUILDING.md#building-nodejs-on-supported-platforms
sudo apt-get install python gcc g++ make
sudo apt-cache showpkg gcc-7-base
sudo apt-get install gcc-7-base=7.3.0-16ubuntu3
sudo apt-cache showpkg libgcc-7-dev
sudo apt-get install libgcc-7-dev=7.3.0-16ubuntu3
sudo apt-get install gcc
sudo apt-get install g++св
sudo apt-get install python3-distutils -y


- скомпилировать node (это займет какое-то время). 
cd /opt/node
ls
./configure
make -j4

- заставить бинарь node работать в терминале при вводе node из любого каталога в системе.
sudo nano environment
    PATH="/opt/node:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u$



