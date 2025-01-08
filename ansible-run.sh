git pull
ansible-playbook -i $1, tool-setup.yml -e ansible_user=ec2-user -e ansible_password=$2 -e tool_name=$3