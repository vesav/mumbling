#!/bin/bash
# Tämä skripti asentaa Mumble-palvelimen Ubuntuun
# Tämän lisäksi palomuuri konfiguroidaan sallimaan vain Mumble ja SSH.

# Asennetaan Mumble, jos entistä asetustiedostoa ei löydy
if [ ! -f /etc/mumble-server.ini ]; then

	# Pyydetään palvelimen nimi valmiiksi
	echo -n "Anna Mumble-palvelimesi nimi: "	
	read palvelin

	# Pyydetään ja tallennetaan salasana kirjautumista varten
	echo -n "Anna Mumbleen kirjautumisen salasana: "
	read salasana
	
	# Lisätään PPA ja päivitetään repo #"
	sudo add-apt-repository ppa:mumble/release
	apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y

	# Asennetaan Mumble ja annetaan käyttäjän suorittaa konfigurointi
	echo "Asennetaan ja konfiguroidaan Mumble-server"
	apt-get install mumble-server -y
	dpkg-reconfigure mumble-server

	# Muokataan mumble-server.ini-tiedostoa ja uudelleenkäynnistetään Mumble-server
	echo "Vaihdetaan salasana ja tiedot"
	sed -i -e 's/serverpassword=/serverpassword='$salasana'/g' /etc/mumble-server.ini
	sed -i -e 's/uname=mumble-server/uname='$palvelin'/g' /etc/mumble-server.ini
	sed -i -e 's/Welcome to this server running/Tervetuloa! Suojatun keskustelun tarjoaa/g' /etc/mumble-server.ini
	sed -i -e 's/Enjoy your stay!/Nauti salaisista keskusteluista!/g' /etc/mumble-server.ini
	service mumble-server restart

	# Asennetaan ufw-palomuuri ja sallitaan tarvittavat portit
	apt-get install ufw -y
	ufw allow ssh
	ufw allow 64738
	ufw status verbose
	ufw enable

# Jos Mumble on jo asennettuna tarjotaan mahdollisuus sen poistamiseen
else

	# Tarjotaan valikko, jossa poistamisesta voi kieltäytyä
	echo "Mumble on jo asennettuna!"
	echo "Haluatko poistaa Mumblen?"
	OPTIONS="Kyllä En"
        select opt in $OPTIONS; do
        	
               # Poistutaan ilman muutoksia
	       if [ "$opt" = "En" ]; then
                echo "Järjestelmään ei tehty muutoksia."
                exit
               
               # Poistetaan Mumble-server ja sen tarvitsemat paketit
               elif [ "$opt" = "Kyllä" ]; then
        	apt-get remove mumble-server -y
		rm /etc/mumble-server.ini
		apt-get autoremove -y
		echo "Mumble poistettiin onnistuneesti."
                exit
               
               # Ilmoitetaan virheellisestä valinnasta
               else
                clear
                echo "Anna joko 1 (Kyllä) tai 2 (En)."
               fi
        done
fi
