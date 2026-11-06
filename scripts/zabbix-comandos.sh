#!/bin/bash
# Comandos utilizados en el servidor Zabbix (Ubuntu) - Practica SNMP
# Mario de Leon - 20250682

# 1. Verificar la IP obtenida por DHCP en la interfaz LAN (ens3)
ip a show ens3
ip route
cat /etc/netplan/*.yaml

# 2. Habilitar la interfaz hacia la nube (ens4) para acceso SSH desde MobaXterm
#    y para instalar paquetes
ip link set ens4 up
dhclient -v ens4
ip a show ens4

# 3. Instalar las herramientas SNMP (snmpget, snmpwalk, snmpset)
apt update
apt install -y snmp

# 4. Lectura SNMP: sysName (.1.5.0), sysContact (.1.4.0), sysLocation (.1.6.0)
snmpget -v2c -c mario0682 10.6.82.1 1.3.6.1.2.1.1.5.0 1.3.6.1.2.1.1.4.0 1.3.6.1.2.1.1.6.0
snmpget -v2c -c mario0682 10.6.82.2 1.3.6.1.2.1.1.5.0 1.3.6.1.2.1.1.4.0 1.3.6.1.2.1.1.6.0

# 5. Consulta completa de la rama "system" (resultado en evidencias-snmp/)
snmpwalk -v2c -c mario0682 10.6.82.1 1.3.6.1.2.1.1
snmpwalk -v2c -c mario0682 10.6.82.2 1.3.6.1.2.1.1

# 6. Intento de escritura SNMP (debe fallar con noAccess por ser comunidad RO)
snmpset -v2c -c mario0682 10.6.82.1 1.3.6.1.2.1.1.5.0 s HACKEADO
snmpset -v2c -c mario0682 10.6.82.2 1.3.6.1.2.1.1.5.0 s HACKEADO
