# Vps Debian 11

Konfiguracja serwera VPS Debian 11 z ovh (de) LEMP, SMTP, SSH, UFW, FAIL2BAN.

```sh
sudo apt install git
git clone https://github.com/atomjoy/vps-debian.git
```

### Dodaj rekordy A do strefy DNS dla subdomeny/domeny oraz rekord SPF dla ip serwera
```
# Rekord A dla domeny
example.com
www.example.com

# Rekord A dla subdomeny fqdn
hello.example.com
www.hello.example.com

# Rekord SPF TXT
v=spf1 a mx ip4:1.2.3.4 include:mx.ovh.com -all

# Vps IP revers dns
hello.example.com
```

### Zaloguj się jako root
Uruchom wszystkie skrypty jako użytkownik root.
```sh
su root
```

### Konfiguracja vps

Zmień parametry przed uruchomieniem.

```sh
sudo bash run.sh
```

### Serwer http dla domeny z ssl

Zmień parametry przed uruchomieniem.

```sh
# Dla domeny
sudo bash ssl.sh
sudo bash vhost.sh

# Dla subdomeny
sudo bash ssl-hello.sh
sudo bash vhost-hello.sh
```

### Usuń użytkownika debian z sudo

```sh
sudo bash sudo-remove.sh
```

### Dodaj użytkownika debian do sudo (bez podawania hasła)

```sh
sudo bash sudo-add.sh
```