#!/bin/bash

# Mes focntions
helps() {

  distoparent="cat /etc/os-release | grep ID_LIKE="

  $distoparent

 echo "

 Aide :

  -h, --helps               Afficher l'aide 

 Global Options :

  -d, --jdk          Installer jdk
  -r, --jre          Installer jre
  -v, --version <number_version> entier      Numero version jdk ou jre

"


echo "
  Vous devez utiliser un de ces exemples pour installer le JDK ou JRE

  (1) Installation jdk version 21


  ###################################################
  #                                                 #
  # Exemple 1 : sudo ./install-jdk.sh --jdk --v 21  #
  #                                                 #
  ###################################################

  ou 

  ###############################################
  #                                             #
  # Exemple 1 : sudo ./install-jdk.sh -d -v 21  #
  #                                             #
  ###############################################

  ou encore 

  ##############################################
  #                                            #
  # Exemple 1 : sudo ./install-jdk.sh -dv 21   #
  #                                            #
  ##############################################



  (2) Installation jre version 21

  ###################################################
  #                                                 #
  # Exemple 2 : sudo ./install-jdk.sh --jre --v 21  #
  #                                                 #
  ###################################################

  ou 

  ###############################################
  #                                             #
  # Exemple 2 : sudo ./install-jdk.sh -r -v 21  #
  #                                             #
  ###############################################

  ou encore 

  #############################################
  #                                           #
  # Exemple 2 : sudo ./install-jdk.sh -rv 21  #
  #                                           #
  #############################################

  21 : Ici c'est la version JDK ou JRE

  NB: Les versions prises en charge sont 8 , 11 ,  17 et 21

"

}

barniere() {
  echo "

  ##########################################################################
  #                                                                        #
  #    #######          ###     ###########   ###########   ###########    #                         
  #    #               #   #        #         #             #              #
  #    #              #     #       #         #             #              #
  #    #   ####      #########      #         ###########   ###########    #
  #    #      #     #         #     #         #                       #    #
  #    #      #    #           #    #         #                       #    #
  #    ########   #             #   #         ###########   ###########    #
  #                                                                        #
  ##########################################################################
  
  "
}

# Recupère la distribution mère
get_disto_like() {

      # Spécifiez le chemin du fichier os-release
      os_release_file="/etc/os-release"

      id_like_line=$(grep "ID_LIKE" "$os_release_file")

          # Utilisez awk pour obtenir la valeur après le signe égal
      id_like_value=$(echo "$id_like_line" | awk -F= '{print $2}' | tr -d '"')

      echo $id_like_value

}

#Fonction pour l'installation de JDK
installjdk() {

echo "[*]: uninstall openJDK"

#Distro variable
debian=debian
rhel=rhel

apt-get remove --purge openjdk-* -y

echo "[**]: install openJDK"

# Appel de la fonction renvoyant la distro mère
distro=$(get_disto_like)

if [[ "$distro" == *"$debian"* ]]; then

cmd="apt-get install openjdk-"$1"-jdk-headless -y"
$cmd

elif [[ "$disto" == *"$rhel"* ]]; then

cmd="dnf install java-"$1"-openjdk -y"
$cmd

fi

javac -version # Test version javac pour la compilation du code Java à bytecode

java -version # Test version java pour l'execution de bytecode au code machine
    
echo "[***] End install JDK"


}
#Fonction pour l'installation de JRE
 installjre() {

echo "[*]: uninstall openJRE"

#Distro variable
debian=debian
rhel=rhel

apt-get remove --purge openjdk-* -y

echo "[**]: install openJRE"


# Appel de la fonction renvoyant la distro mère
distro=$(get_disto_like)

if [[ "$distro" == *"$debian"* ]]; then

cmd="apt-get install openjdk-"$1"-jre-headless -y"
$cmd

    
elif [[ "$distro" == *"$rhel"* ]]; then
    
cmd="dnf install java-"$1"-openjdk-headless -y"
$cmd

fi

java -version # Test version java pour l'execution de bytecode au code machine

echo "[***] End install JRE"


}


name=$1 # --jdk ou --jre ou --helps

max_arg=3

barniere


if [ $name == "--helps" ] || [ $name == "-h" ]; then
 helps
else

    if [ $# == $max_arg ]; then

        if [ $3 -eq 8 ] || [ $3 -eq 11 ] || [ $3 -eq 17 ] || [ $3 -eq 21 ]; then

            if [ $name = "--jdk" ] || [ $name = "-d" ]; then
            installjdk $3
            elif [ $name = "--jre" ] || [ $name = "-r" ]; then
            installjre $3
            else
            helps
            fi
         else
        helps

        fi
    elif [ $# == 2 ]; then 

      if [ $2 -eq 8 ] || [ $2 -eq 11 ] || [ $2 -eq 17 ] || [ $2 -eq 21 ]; then

            if [ $name = "-dv" ]; then
            installjdk $2
            elif [ $name = "-rv" ]; then
            installjre $2
            else
            helps
            fi
      else
     helps
      fi

    else 

    helps

    fi

fi


