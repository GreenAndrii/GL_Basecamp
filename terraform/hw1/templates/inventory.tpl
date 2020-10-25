%{ for id in range(count) ~}
group_${id}:
  hosts:
    host_${id}:
      ansible_host: ${hw1_stack["${id}"]}
%{ endfor ~}

iaas:
  children:
    group_0:
    group_1:

all:
  vars:
    ansible_user: ${ssh_user}
    ansible_ssh_private_key_file: "/home/green/.aws/${key_name}.pem"
