cd ~
touch bash.sh
nano bash.sh


#!/bin/bash
mkdir -p ~/tmp/lesson3/permissions
cd ~/tmp/lesson3/permissions
echo "Hello, Linux!" > task3.txt
echo "==>Создан файл task3.txt"
ln task3.txt  task3_hardlink.txt
ln -s task3.txt task3_symlink.txt
ln -s task3_symlink.txt ~/tmp/lesson3/task3_second_symlink.txt
ls -Rlai ~/tmp
echo "==>Содержимое файлов:"
cat $(ls) ~/tmp/lesson3/*
mv ./*link.txt ~/tmp
echo "==>Ссылки перемещены"
ls -Rlai ~/tmp
echo "==>Содержимое файлов:"
cat $(ls) ~/tmp/*


??? Должны ли выведенные иноды совпадать или отличаться? Почему?
Совпадают иноды у файла task3.txt и жетской ссылки, т.к. жетская ссылка ссылается на ту же иноду, что и файл.
Ссылка на символьную ссылку – не работает. После перемещения ссылок рабочей осталась только жёсткая ссылка.


chmod +x ~/bash.sh
bash bash.sh
rm -r ~/tmp

### Вывод скрипта:
==>Создан файл task3.txt
/home/zoya/tmp:
total 12
 17933 drwxr-xr-x  3 zoya zoya 4096 May 11 20:00 .
294913 drwxr-xr-x 18 zoya zoya 4096 May 11 20:00 ..
 17934 drwxr-xr-x  3 zoya zoya 4096 May 11 20:00 lesson3

/home/zoya/tmp/lesson3:
total 12
17934 drwxr-xr-x 3 zoya zoya 4096 May 11 20:00 .
17933 drwxr-xr-x 3 zoya zoya 4096 May 11 20:00 ..
17935 drwxr-xr-x 2 zoya zoya 4096 May 11 20:00 permissions
17938 lrwxrwxrwx 1 zoya zoya   17 May 11 20:00 task3_second_symlink.txt -> task3_symlink.txt

/home/zoya/tmp/lesson3/permissions:
total 16
17935 drwxr-xr-x 2 zoya zoya 4096 May 11 20:00 .
17934 drwxr-xr-x 3 zoya zoya 4096 May 11 20:00 ..
17936 -rw-r--r-- 2 zoya zoya   14 May 11 20:00 task3_hardlink.txt
17937 lrwxrwxrwx 1 zoya zoya    9 May 11 20:00 task3_symlink.txt -> task3.txt
17936 -rw-r--r-- 2 zoya zoya   14 May 11 20:00 task3.txt
==>Содержимое файлов:
Hello, Linux!
Hello, Linux!
Hello, Linux!
cat: /home/zoya/tmp/lesson3/permissions: Is a directory
cat: /home/zoya/tmp/lesson3/task3_second_symlink.txt: No such file or directory
==>Ссылки перемещены
/home/zoya/tmp:
total 16
 17933 drwxr-xr-x  3 zoya zoya 4096 May 11 20:00 .
294913 drwxr-xr-x 18 zoya zoya 4096 May 11 20:00 ..
 17934 drwxr-xr-x  3 zoya zoya 4096 May 11 20:00 lesson3
 17936 -rw-r--r--  2 zoya zoya   14 May 11 20:00 task3_hardlink.txt
 17937 lrwxrwxrwx  1 zoya zoya    9 May 11 20:00 task3_symlink.txt -> task3.txt

/home/zoya/tmp/lesson3:
total 12
17934 drwxr-xr-x 3 zoya zoya 4096 May 11 20:00 .
17933 drwxr-xr-x 3 zoya zoya 4096 May 11 20:00 ..
17935 drwxr-xr-x 2 zoya zoya 4096 May 11 20:00 permissions
17938 lrwxrwxrwx 1 zoya zoya   17 May 11 20:00 task3_second_symlink.txt -> task3_symlink.txt

/home/zoya/tmp/lesson3/permissions:
total 12
17935 drwxr-xr-x 2 zoya zoya 4096 May 11 20:00 .
17934 drwxr-xr-x 3 zoya zoya 4096 May 11 20:00 ..
17936 -rw-r--r-- 2 zoya zoya   14 May 11 20:00 task3.txt
==>Содержимое файлов:
Hello, Linux!
cat: /home/zoya/tmp/lesson3: Is a directory
Hello, Linux!
cat: /home/zoya/tmp/task3_symlink.txt: No such file or directory
