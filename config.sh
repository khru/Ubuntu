clear
if [[ $EUID -ne 0 ]]; then
echo "Este script requiere privilegios de superusuario (root)" 1>&2
exit 1
fi
echo "  _    _"                
echo " | |  | |"               
echo " | | _| |__  _ __ _   _ "
echo " | |/ / '_ \| '__| | | |"
echo " |   <| | | | |  | |_| |"
echo " |_|\_\_| |_|_|   \__,_|"
echo "========================================================="
echo "                        OPCIONES                         "
echo "========================================================="
echo " 1 - Modificar el archivo sources.list"
echo " 2 - Modificar interfaces"
echo " 3 - Modificar el archivo hosts"
echo " 4 - Modificar el archivo hostname"
echo " 5 - Parar servicios de red"
echo " 6 - Iniciar servicios de red"
echo " 7 - Reiniciar servicios de red"
echo " 8 - Ping a una maquina"
echo " 9 - Ifconfig"
echo " 10 - Tumbar interfaces"
echo " 11 - Levantar interfaces"
echo " 12 - Editar el fichero 10periodic"
echo " 13 - Salir"
echo " 14 - Modificar config.sh"
echo "=========================================================="
echo -n "Selecione una opcion: "
read opcion
case $opcion in
	1) nano /etc/apt/sources.list
	;;
	2) nano /etc/network/interfaces
	;;
	3) nano /etc/hosts
	;;
	4) nano /etc/hostname
	;;
	5)service networking stop
	read -p "Presione ENTER para continuar ..."
	;;
	6)while true;do echo -n "#"; sleep 1;done &
		service networking start
		kill $!; trap "kill $!" SIGTERM
		read -p "Presione ENTER para continuar ..."
	;;
	7)service networking restart
	read -p "Presiones ENTER para continuar ..."
	;;
	8)echo -n "Inserte la direccion IP del host: "
	read ip
		ping -c 10 $ip
	read -p "Este es el resultado, presione ENTER para continuar"
	;;
	9) ifconfig
	 read -p "Presione ENTER para continuar"
	;;
	10)ifconfig
		echo -n "inserte la interfaz que desa tumbar: "
		read interfaz
		clear
		ifconfig $interfaz down
		ifconfig
		read -p "Presione ENTER para continuar ..."
	;;
	11)	echo 
	        echo "======================================================"
		echo "==>  Lista de interfaces levantados y SIN LEVANTAR <=="
		echo "======================================================"
		ifconfig -a
		echo -n "Inserte la interfaz que desea levantar: "
		read interfaz
		clear
		ifconfig $interfaz up
		ifconfig
		read -p "Presione ENTER para continuar ..."
	;;
	12)nano /etc/apt/apt.conf.d/10periodic
	;;
	13)exit
	;;
	14)nano config.sh
	;;
	*) echo "Opcion erronea inserte un parametro adecuado"
	read -p "Presione ENTER para continuar"
esac
done
