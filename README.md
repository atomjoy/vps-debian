# Vps Debian 11

Konfiguracja serwera VPS Debian 11 z ovh (de) LEMP, SMTP, SSH, UFW, FAIL2BAN.

```sh
sudo apt install git
git clone https://github.com/atomjoy/vps-debian.git
```

### Dodaj rekordy A do strefy DNS dla subdomeny/domeny

Vps hostname: hello.example.com a revers dns: hello.example.com dla ip serwera. Uruchom skrypty z sudo lub jako root.

```sh
# Dla domeny
example.com
www.example.com

# Dla subdomen fqdn
hello.example.com
www.hello.example.com
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
