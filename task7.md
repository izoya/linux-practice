# Задание 1

/etc/nginx/conf.d/site.conf

```
server{
	listen 80;
	server_name zoyaVB;
	location / {
		if ($http_user != '') {
			return 200 "Hi, $http_user!";
		}
		return 404 "Page not found";
	}
	location /admin {
		return 200 "HTTP admin page";
	}
}

```
curl -L http://10.0.2.15 -D - -H "Host: zoyaVB"
curl -L http://10.0.2.15 -D - -H "Host: zoyaVB" -H "User: Zoya"

# Задание 2
## 1. найти информацию о том, что такое самоподписанные сертификаты и сгенерировать такой для своего вэб сервера. Написать своими словами, что это такое и как сгенерить.

Самоподписанный сертификат - аналог сертификата ssl, используемый в процессе разработки приложения для эмуляции соединения по протоколу https. При публикации приложения заменяется сертификатом, выпущенным доверенным сертификационным центром.

sudo nano localhost.conf

```
[req]
default_bits       = 2048
default_keyfile    = localhost.key
distinguished_name = req_distinguished_name
req_extensions     = req_ext
x509_extensions    = v3_ca

[req_distinguished_name]
countryName                 = Country Name (2 letter code)
countryName_default         = AU
stateOrProvinceName         = State or Province Name (full name)
stateOrProvinceName_default = Queensland
localityName                = Locality Name (eg, city)
localityName_default        = Brisbane
organizationName            = Organization Name (eg, company)
organizationName_default    = localhost
organizationalUnitName      = organizationalunit
organizationalUnitName_default = Development
commonName                  = Common Name (e.g. server FQDN or YOUR name)
commonName_default          = localhost
commonName_max              = 64

[req_ext]
subjectAltName = @alt_names

[v3_ca]
subjectAltName = @alt_names

[alt_names]
DNS.1   = localhost
DNS.2   = 127.0.0.1

```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout localhost.key -out localhost.crt -config localhost.conf
sudo mkdir /etc/nginx/ssl
sudo cp localhost.crt /etc/nginx/ssl/localhost.crt
sudo cp localhost.key /etc/nginx/ssl/localhost.key

## 2. добавить SSL соединение для дифолтного виртуального хоста nginx, используя порт 443. Прикрепить конфиги nginx.

sudo nano /etc/nginx/sites-available/default

```
# Default server configuration

server {
	listen 80 default_server;
	listen [::]:80 default_server;

	# SSL configuration
	listen 443 ssl default_server;
	listen [::]:443 ssl default_server;
	ssl_certificate /etc/nginx/ssl/localhost.crt;
	ssl_certificate_key /etc/nginx/ssl/localhost.key;

	root /var/www/html;

	index index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		try_files $uri $uri/ =404;
	}
}


```
sudo nginx -t
sudo nginx -s reload
curl -Lk https://10.0.2.15 -D -

## 3. откройте в браузере страницу хоста и посмотрите, как браузер реагирует на самоподписанные сертификаты.

Браузер выдаёт предупреждение о потенциальной угрозе безопасности
https://localhost/
Warning: Potential Security Risk Ahead

## 4. мы говорили о необходимости шифровать симметрично. При этом проблем с получением ассиметричных сертификатов нет. Зачем такая сложная схема для установления SSL соединения? Почему бы не шифровать ассиметрично? Своими словами.

Асимметричное шифрование требует больше ресурсов и времени, т.к. асимметричные ключи намного длиннее (2048 бит против 128-256 у симметричных ключей).

