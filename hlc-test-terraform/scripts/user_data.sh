#!/usr/bin/env bash

apt update
snap install docker
snap install aws-cli --classic
snap install jq
cat > /etc/check_peers.sh <<'_END'
#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:$PATH
touch /etc/peers
region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/\(.*\)[a-z]/\1/')
PRIVATEIPS=$(aws ec2 describe-instances --region $region --filters "Name=tag:aws:autoscaling:groupName,Values=$(aws autoscaling describe-auto-scaling-instances --region $region --instance-ids="$(ec2metadata --instance-id)" | jq -r '.AutoScalingInstances[].AutoScalingGroupName')" --query 'Reservations[].Instances[].PrivateIpAddress' --output text)
IFS=$' ' read -r -a old_peers <<< $(cat /etc/peers)
IFS=$'\t' read -r -a current_peers <<< "$PRIVATEIPS"
for peer in "${current_peers[@]}"
do
  if (( $(docker ps -q | wc -l) > 0 ))
  then
    if [[ ! " ${old_peers[@]} " =~ " ${peer} " ]]
    then
      docker rm -f $(docker ps -aq)
      restart=true
    fi
  fi
  if $restart
  then
    for element in "${current_peers[@]}"
    do
      arguments="$arguments --addpeer=$element:18130 "
    done
    docker run -d -p 18130:18130 -p 18131:18131 halalchain/qitmeer $arguments --modules=miner --modules=qitmeer
  fi
done
echo $PRIVATEIPS > /etc/peers
_END
chmod +x /etc/check_peers.sh
echo -e "*/5 * * * * /etc/check_peers.sh >> /var/log/check_peers.log 2>&1" | crontab -
