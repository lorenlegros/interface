#!/bin/bash
#
#################################################################################
#																				#
#																				#
# 					SCRIPT INSTALLATION ENVIRONNEMENT LINUX						#
# 								By Kimba	v23									#
#  	                © tous droits réservé à KIMBA23								#
# 																				#
#																				#
#################################################################################
#
# apres installation : apt-get install kali-linux-all kali-linux-full kali-menu


introduction(){

			echo "SCRIPT INSTALLATION ENVIRONNEMENT LINUX"
			echo " © tous droits réservés à KIMBA"
			echo "By Kimba	v23"
			sleep 5
			clear
			proxy
			setxkbmap fr
			apt-get install sudo
			repository

}
proxy(){
			echo "Qu'elle est l'ip du proxy ? : "
			read ipproxy
			echo "Qu'elle est le port du proxy ? : "
			read portproxy
				export http_proxy=http://$ipproxy:$portproxy
				export https_proxy=https://$ipproxy:$portproxy
				export ftp_proxy=ftp://$ipproxy:$portproxy
	
			# Creation du dossier ou les configurations de base seront sauvegardées
			mkdir /etc/archives
			
				cp /etc/profile /etc/archives/profile.old
				echo "" >> /etc/profile
				echo "" >> /etc/profile
				echo "export http_proxy='http://$ipproxy:$portproxy'" >> /etc/profile
				echo "export https_proxy='https://$ipproxy:$portproxy'" >> /etc/profile
				echo "export ftp_proxy='ftp://$ipproxy:$portproxy'" >> /etc/profile
			
			###### Configuration /etc/bash.bashrc
				
				cp /etc/bash.bashrc /etc/archives
				echo "" >> /etc/bash.bashrc
				echo "" >> /etc/bash.bashrc
				echo "export http_proxy='http://$ipproxy:$portproxy'" >> /etc/bash.bashrc
				echo "export https_proxy='https://$ipproxy:$portproxy'" >> /etc/bash.bashrc
				echo "export ftp_proxy='ftp://$ipproxy:$portproxy'" >> /etc/bash.bashrc
			
			###### Configuration /etc/wgetrc
				
				cp /etc/wgetrc /etc/archives
				echo "" >> /etc/wgetrc
				echo "" >> /etc/wgetrc
				echo "http_proxy='http://$ipproxy:$portproxy'" >> /etc/wgetrc
				echo "https_proxy='http://$ipproxy:$portproxy'" >> /etc/wgetrc
				echo "ftp_proxy='http://$ipproxy:$portproxy'" >> /etc/wgetrc
				echo "" >> /etc/wgetrc
				echo "use_proxy = on" >> /etc/wgetrc
			
			###### Configuration /etc/apt/apt.conf.d/proxyPerso.conf
				
				echo "" >> /etc/apt/apt.conf.d/proxyPerso.conf
				echo "" >> /etc/apt/apt.conf.d/proxyPerso.conf
				echo "Acquire::http::proxy 'http://$ipproxy:$portproxy/';" >> /etc/apt/apt.conf.d/proxyPerso.conf
				echo "Acquire::ftp::proxy 'ftp://$ipproxy:$portproxy/';" >> /etc/apt/apt.conf.d/proxyPerso.conf
				echo "Acquire::https::proxy 'https://$ipproxy:$portproxy/';" >> /etc/apt/apt.conf.d/proxyPerso.conf
				cp /etc/apt/apt.conf.d/proxyPerso.conf /etc/archives 
			
			testconnexion{

				for (( ; ; )); do 
				  ping -q -c 1 8.8.8.8 >/dev/null 2>&1 
				  if [ $? -eq 0 ]; then 
					clear
					echo ""
					echo "Les parametres de connexion sont faux le script va prendre fin.."
					sleep 5
					exit
					break 
				  fi 
				done

				}
			testconnexion
}
repository(){

					apt-get update -y && sudo apt-get upgrade -y && sudo apt-get -y dist-upgrade
					
					cd /etc/apt 
					mkdir archives	
					mv /etc/apt/sources.list /etc/apt/archives	
					cd /etc/apt	

					######### Ecriture du nouveau fichier source liste par dessus l'ancien ################

					echo "" >> /etc/apt/sources.list 
					echo "" >> /etc/apt/sources.list
					echo "" >> /etc/apt/sources.list


					######### Paquets de base : ne pas supprimer ( interdit ) ################

					echo "#depot kali linux : " >> /etc/apt/sources.list
					echo "deb http://http.kali.org/kali sana main non-free contrib" >> /etc/apt/sources.list
					echo "deb-src http://http.kali.org/kali sana main non-free contrib" >> /etc/apt/sources.list
					echo "" >> /etc/apt/sources.list
					echo "" >> /etc/apt/sources.list
					echo "deb http://security.kali.org/kali-security sana/updates main contrib non-free" >> /etc/apt/sources.list
					echo "deb-src http://security.kali.org/kali-security sana/updates main contrib non-free" >> /etc/apt/sources.list
					echo "" >> /etc/apt/sources.list
					
					############################## Attribution des droits sur le fichier ( Tout le monde a tous les droits ) #############################
					############################################# Et vérification du fichier : "sources.list" ############################################

					chmod -R 777 /etc/apt/sources.list
					cat /etc/apt/sources.list
					sleep 10
					
					apt-get update -y
					apt-get -y install kali-archive-keyring
					apt-get update -y && apt-get upgrade -y && apt-get -y dist-upgrade
					
					
					
}





# Programme principal
if [ "$(id -u)" != "0" ]; then
	echo "Vous devez etre admin (root) pour lancer le script"
	echo "Syntax: sudo bash $0"
	exit 1
fi
introduction
start

bashrcc(){
# Le fichier "Bashrc est le fichier qui se lance au démarrage du shell"
fig="KIMBA"
echo "figlet $fig" >> /root/.bashrc
PROMPT_COMMAND='PS1="\[\033[0;34m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[34m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h@\`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`@`pwd`\007"'
echo $PROMPT_COMMAND >> /root/.bashrc
echo $PROMPT_COMMAND >> /home/$USERNAME/.bashrc
}

bashrcc
