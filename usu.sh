!/bin/bash
#limpiar pantalla
while true;
do
clear
#comprobar si el usuario es root mediante un if
if [[ $EUID -ne 0 ]]
 	then
		echo "Este script ha de ser ejecutado por root" 1>&2
		exit 1
fi
echo "  _    _"                
echo " | |  | |"               
echo " | | _| |__  _ __ _   _ "
echo " | |/ / '_ \| '__| | | |"
echo " |   <| | | | |  | |_| |"
echo " |_|\_\_| |_|_|   \__,_|"
#Imprimo en pantalla un titulo y realizo un bucle para el menu

echo "======================================================="
echo "|                 Script Administracion LINUX         |"
echo "|                  Emmanuel Valverde Ramos            |"
echo "|                            khru                     |"
echo "======================================================="
echo "_______________________________________________________"
echo "|1 - Creacion de usuarios                             |"
echo "|2 - Creacion de un grupo                             |"
echo "|3 - Cambiar la contraseña a un usuario               |"
echo "|4 - Añadir a un usuario a un grupo                   |"
echo "|5 - Borrar un usuario                                |"
echo "|6 - Borrar un grupo                                  |"
echo "|69 -Salir                                            |"
echo "|_____________________________________________________|"
echo -n "Selecione una operacion: "
read opcion
	case $opcion in
		1)
			echo -n "Ingrese el nombre del usuario que desea crear: "
			read nombre
			while true;
			do
				echo -n "Escribe la contraseña para este usuario: "
				read pass
				echo -n "Repita la contraseña: "
				read pass1
				if [ "$pass" != "$pass1" ];
					then
					echo "Las contraseñas no coninciden"
					else
                                          break;
                                fi
                         done
					useradd -d /home/$nombre -m -s /bin/bash $nombre
					echo $nombre:$pass | chpasswd
					cat /etc/passwd  | grep $nombre
					while true;
					do
						echo -n "Desea añadir informacion adicional a el usuario "$nombre "(y/n): "
						read yn
						if [ "$yn" == "y" ]
							then
								chfn $nombre
							else
								break;
						fi
					done
					echo "======================="
					echo "1 - Voler al menu"
					echo "2 - Salir"
					echo "========================"
					echo -n "Selecione una opcion:"
					read  opcion
					case $opcion in
						1) clear;;
						2) exit;;
						*) echo "Opcion erronea";
					esac
		 ;;
		2)
			echo -n "Ingresa el nombre del grupo que desea crear: "
			read grupo
			addgroup $grupo
			cat /etc/group | grep $grupo
			echo "======================"
			echo "1 - Volver al menu"
			echo "2 - Salir"
			echo "======================"
			echo -n "Selecione una opcion: "
			read opcion
			case $opcion in
				1) clear;;
				2) exit;;
				*) echo "Opcion erronea";;
			esac
		;;
		3)
			echo -n "Ingresa el nombre del usuario al cual le deseas cambiar la contraseña: "
			read usu
			while true;
			do
				echo -n "Nueva contraseña para el usuario "$usu": "
				read pass
				echo -n "Vuelva a escribir la contraseña: "
				read pass1
				if [ "$pass" != "$pass1" ]
					then
						echo "Las contraseñas no coinciden"
					else
						break;
				fi
			done
			echo $usu:$pass | chpasswd
			echo "===================="
			echo "1 - Volver al menu"
			echo "2 - Salir"
			echo "===================="
			echo -n "Selecione una opcion: "
			read opcion
			case $opcion in
				1) ;;
				2) exit;;
				*) echo "Opcion erronea";;
			esac
		;;
		4)
			while true;
			do
				echo -n "Nombre de usuario: "
				read nom
				echo -n "Nombre de grupo: "
				read group
				echo -n "¿Es el usuario? "$nom "¿Y el grupo? "$group "(y/n): "
				read yn
				if [ "$yn" == "n"  ]
				then
					echo "Inserte los datos correctos"
				else
					break;
				fi
			done
			adduser $nom $group
			cat /etc/group | grep $nom | grep $group
			echo "===================="
			echo "1 - Volver al menu"
			echo "2 - Salir"
			echo "===================="
			echo -n "Seleciona una opcion: "
			read opcion
			case $opcion in
				1) clear;;
				2) exit;;
				*) echo "opcion erronea";;
			esac
		;;
		5)
			while true;
			do
				echo -n "Nombre del usuario que dese eliminar: "
				read nom
				echo -n "¿Esta seguro de que "$nom "es el usuario que desea eliminar?(y/n): "
				read yn
				if [ "$yn" == "n" ]
				then
					echo "No estas seguro"
				else
					break;
				fi
			done
			userdel -r $nom
			echo
			echo "========================="
			echo "1 - Volver al menu"
			echo "2 - Salir"
			echo "========================="
			echo -n "Selecione una opcion: "
			read opcion
			case $opcion in
				1) clear;;
				2) exit;;
				*) echo "Opcion erronea";;
			esac
		;;
		6)
			while true;
			do
				echo -n "Grupo que desea eliminar: "
				read gupo
				echo -n "Esta seguro de que "$grupo "es el grupo que desea eliminar(y/n): "
				read yn
				if [ "$yn" == "n" ]
					then
					echo "Inserte los datos correctos"
					else
					break;
				fi
			done
			delgroup $gupo
			echo
			echo "========================"
			echo "1 - Volver al menu"
			echo "2 - Salir"
			echo "========================"
			echo "Selecione una opcion: "
			read opcion
			case $opcion in
				1) clear;;
				2) exit;;
				*) echo "Opcion invalida, inentelo de nuevo"
			esac
		;;
		69) clear && exit
		;;
		*) echo "Opcion invalida, intentelo de nuevo"
			read -p "Pressione Enter para continuar..."

	esac

done
