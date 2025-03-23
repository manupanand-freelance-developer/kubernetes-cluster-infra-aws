#!/bin/bash 

 export AWS_USER=$TF_VAR_aws_user
 export AWS_PASSWORD=$TF_VAR_aws_password
 export role_name =$TF_VAR_role_name
 export ANSIBLE_HOST_KEY_CHECKING=False
# echo "AWS_USER is set to: $AWS_USER" | tee -a /var/log/user_data.log
# echo "AWS_PASSWORD is set to: $AWS_PASSWORD" | tee -a /var/log/user_data.log
# echo $role_name | tee -a /var/log/user_data.log

# Set the password for the user "ec2-user" or any user you have
echo "${AWS_USER}:${AWS_PASSWORD}" | sudo chpasswd   2>&1 | tee -a /var/log/user_data.log


# Enable password authentication in SSH
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config  2>&1 | tee -a /var/log/user_data.log

sudo sed -i 's/^ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config  2>&1 | tee -a /var/log/user_data.log


# Ensure UsePAM is enabled
echo "UsePAM yes" | sudo tee -a /etc/ssh/sshd_config 

sudo systemctl restart daemon-reexec
sudo systemctl restart sshd
sleep 600
# install ansible core
sudo dnf install -y ansible-core  2>&1 | tee -a /var/log/user_data.log

# install setup 
ansible-pull -i localhost, -U https://github.com/manupanand-freelance-developer/learn-devops-project-infra  tools-infra/ansible/setup.yml  -e ansible_user=${AWS_USER} -e ansible_password=${AWS_PASSWORD} -e role_name=${role_name} 2>&1 | tee -a /var/log/user_data.log
