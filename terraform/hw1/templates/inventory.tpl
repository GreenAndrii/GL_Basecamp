%{ for id in range(count) ~}
group_${id}:
  hosts:
    host_${id}:
      ansible_host: ${hw1_stack["${id}"]}
%{ endfor ~}
iaas:
  children:
%{ if count > 1 }
%{ for id_iaas in range(2) ~}
    group_${id_iaas}:
%{ endfor ~}
%{ else }
    group_0:
%{ endif }

all:
  vars:
    ansible_user: ${ssh_user}
    ansible_ssh_private_key_file: "/home/green/.aws/${key_name}.pem"
