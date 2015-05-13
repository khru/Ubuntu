#!/bin/bash

echo "Introduce la ruta y el archivo que deseas enviar(Ej.: /home/daw14-24/c.sql): "
read enviar

echo "Introduce la dirección IP a la cual deseas enviar el archivo: "
read ip
scp $enviar $usuario@$ip:/home/iescierva
