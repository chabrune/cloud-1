if [ ! -f ~/.ssh/tf-digitalocean ]; then
  yes | ssh-keygen -t rsa -b 4096 -f ~/.ssh/tf-digitalocean -N "" -q
fi


terraform apply -auto-approve

IP_ADDRESS=$(terraform output -json ip_address | jq -r '.')
echo "[cloud]" > hosts.ini
echo "$IP_ADDRESS" >> hosts.ini
ansible-playbook -i hosts.ini playbook.yml 
# --private-key=~/.ssh/tf-digitalocean

# ssh terraform@$(terraform output -json ip_address | jq -r '.') -i ~/.ssh/tf-digitalocean