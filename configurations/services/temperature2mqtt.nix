{ pkgs, ... }:
let
  package = builtins.fetchGit {
    url = "https://github.com/JsBergbau/MiTemperature2.git";
    rev = "c25ab3645199aa5c802d4c852f760dc82ba2bf27";
  };

  pythonDeps = python-packages: with python-packages; [ 
    bluepy
    requests
    bluepy-devices
    types-requests
    paho-mqtt
    pybluez
    pycryptodomex
  ];
  pythonWithDeps = pkgs.python3.withPackages pythonDeps;

  broker = "172.16.0.77";
  userPass = "mqtt";
  name = "Livingroom";
  mac = "A4:C1:38:B1:61:77";

  sendToMqtt = with pkgs;writeShellScript "sendToMqtt" ''
    ${mosquitto}/bin/mosquitto_pub -h ${broker} -p 1883 -t "homeassistant/sensor/$2_temp/config" -u ${userPass} -P ${userPass} -i "mibridge" -m '{"device_class": "temperature", "name": "'$2'_temp", "unique_id": "lywsd03mmc_'$2'_temp", "device": { "name":"lywsd03mmc_'$2'", "identifiers": "lywsd03mmc_'$2'", "model": "LYWSD03MMC", "manufacturer": "Xiaomi"}, "state_topic": "homeassistant/sensor/'$2'/state", "unit_of_measurement": "°C", "value_template": "{{ value_json.temperature}}","platform": "mqtt" }'
    ${mosquitto}/bin/mosquitto_pub -h ${broker} -p 1883 -t "homeassistant/sensor/$2_humi/config" -u ${userPass} -P ${userPass} -i "mibridge" -m '{"device_class": "humidity", "name": "'$2'_humi", "unique_id": "lywsd03mmc_'$2'_humi", "device": { "name":"lywsd03mmc_'$2'", "identifiers": "lywsd03mmc_'$2'", "model": "LYWSD03MMC", "manufacturer": "Xiaomi"}, "state_topic": "homeassistant/sensor/'$2'/state", "unit_of_measurement": "%", "value_template": "{{ value_json.humidity}}","platform": "mqtt" }'
    ${mosquitto}/bin/mosquitto_pub -h ${broker} -p 1883 -t "homeassistant/sensor/$2_battlevel/config" -u ${userPass} -P ${userPass} -i "mibridge" -m '{"device_class": "battery", "name": "'$2'_batt", "unique_id": "lywsd03mmc_'$2'_batt", "device": { "name":"lywsd03mmc_'$2'", "identifiers": "lywsd03mmc_'$2'", "model": "LYWSD03MMC", "manufacturer": "Xiaomi"}, "state_topic": "homeassistant/sensor/'$2'/state", "unit_of_measurement": "%", "value_template": "{{ value_json.batterylevel}}","platform": "mqtt" }'
    ${mosquitto}/bin/mosquitto_pub -h ${broker} -p 1883 -t "homeassistant/sensor/$2_battvolt/config" -u ${userPass} -P ${userPass} -i "mibridge" -m '{"device_class": "voltage", "name": "'$2'_volt", "unique_id": "lywsd03mmc_'$2'_volt", "device": { "name":"lywsd03mmc_'$2'", "identifiers": "lywsd03mmc_'$2'", "model": "LYWSD03MMC", "manufacturer": "Xiaomi"}, "state_topic": "homeassistant/sensor/'$2'/state", "unit_of_measurement": "v", "value_template": "{{ value_json.batteryvoltage}}","platform": "mqtt" }'
    ${mosquitto}/bin/mosquitto_pub -h ${broker} -p 1883 -t "homeassistant/sensor/$2/state" -u ${userPass} -P ${userPass} -i "mibridge" -m '{ "temperature": '$3', "humidity": '$4', "batteryvoltage" : '$5', "batterylevel": '$6' }'
  '';
in
{
  systemd.services.temperature2mqtt = {
    description = "temperature2mqtt";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      User = "nobody";
      Group = "nogroup";
      Restart = "on-failure";
      ExecStart = "${pythonWithDeps}/bin/python ${package}/LYWSD03MMC.py -d ${mac} -b 1000 -r --debounce --skipidentical 50 --name ${name} --callback ../../../${sendToMqtt}";
    };
  };
}
