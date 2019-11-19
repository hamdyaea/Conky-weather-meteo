![Awesome](awesome.svg)

# My conky confi
iguration file with weather. 


![Screenshot](screenshot3.png)


## What's this file ?


This is the config of my conky. You have to configure linux to launch conky at startup and put this .conkyrc in you home directory.  


## Weather / Meteo

Modify the last line for your location and language :

```sh
${color #00ff00}${texeci 3600 curl "wttr.in/Arconciel?qT0&lang=fr"}
```
You can find more information there : https://wttr.in/:help


By default it use the eth0 network interface. You can find your network interface with #ifconfig then modify those two lines with the name of the network interface. You have to modify it after downspeed, upspeed, downspeedgraph, upspeedgraph :

```sh
Down:${color #8844ee} ${downspeed eth0} k/s${color lightgrey} ${offset 70}Up:${color #22ccff} ${upspeed eth0} k/s
${color black}${downspeedgraph eth0 32,150 ff0000 0000ff} $alignr${color black}${upspeedgraph eth0 32,150 0000ff ff0000}
```

The weather police is DejaVu.


To install it:

```sh
sudo apt install ttf-dejavu
```

On ArchLinux, Manjaro etc...

```sh
sudo pacman -S ttf-dejavu
```


## Latitude and longitude / Sunrise, Sunset, Day length

You need to install jq to be able to parse the json file with the sun information

All information here : https://stedolan.github.io/jq/download/

On Debian, Ubuntu, etc.

```sh
sudo apt install jq
```

On Arch Linux, Manjaro, etc.


```sh
sudo pacman -S jq
```

On Fedora, CentOS, etc.

```sh
sudo dnf install jq
```

Modify the file sunsetsunrise.sh and put it in your home folder with the .conkyrc. You have to put your longitude and latitude for sunrise and sunset in your current location.
You have to let +1 if you are in UTC+1, +2 if you are in UTC+2 etc. 
Read the information inside the sunsetsunrise.sh file. It use the service of https://sunrise-sunset.org/api

## Islamic Adhan pray time

Change all the paths in .conkyrc and the other files to your /home/youruser/

First make executable islamictime.sh with chmod +x islamictime.sh

Change the location to yours and the timezone to yours. You can fint all the information about it there : https://aladhan.com/prayer-times-api

## Speedtest
Put the file speedtest.bash with your .conkyrc in your ~home folder and change the path to to it in the .conkyrc file

## Languages

I writed it in french but you can modify the .conkyrc and the two shell scritps to your languages.


## Developer - Author

Hamdy Abou El Anein


## Homepage

http://www.daylightlinux.ch 
