# mumbling

Asenna Mumble Ubuntuun ja konfiguroi ufw Bash-skriptin avulla. Palomuurista sallitaan vain SSH ja Mumble-palvelimen portti. Samalla skriptillä onnistuu poistaminenkin.

</br>

Kirjaudu roottina ja lataa mumbling.sh:
##### wget https://raw.githubusercontent.com/vesav/mumbling/master/mumbling.sh

</br>

Anna skriptille suoritusoikeudet:
##### chmod 755 mumbling.sh

</br>

Suorita skripti:
##### ./mumbling.sh

</br>

Mumble-palvelin on nyt käyttövalmis. Kirjaudu sisään Mumble-sovelluksella antamalla palvelimesi IP-osoite, käyttäjänimeksi keksimäsi nimi ja salasanaksi skriptin yhteydessä antamasi salasana. Tarvittaessa konfiguroi asetuksia tarkemmin:
##### /etc/mumble-server.ini
