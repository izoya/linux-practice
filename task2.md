Вкладка Adapter2 не активна, Adapter1 поменяла с NAT на Bridge (Windows 10)
UBUNTU:
sudo apt-get update
sudo apt-get install git
sudo apt-get install openssh-server
sudo systemctl status sshd
ip a // 192.168.31.141
* ключ уже был создан ранее для гита, поэтому ssh keygen не понадобилось
cp '/home/zoya/Desktop/id_rsa.pub' ~/.ssh/ cd 
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys 


Windows:
ssh zoya@192.168.31.141 -i /c/Users/Zoya/.ssh/id_rsa


#git-команды:
git checkout -b task2
git add .
git status
git commit -m 'task2'
git push --set-upstream origin task2
