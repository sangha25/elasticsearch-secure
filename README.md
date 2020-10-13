# In this assignment we will provision AWS infrastructure using Terraform specific to elasticsearch requirements.
we need below resources in aws

AMI  ==> Amazon Linux 2 AMI or ubuntu

Instance Type == >  t3.medium ( This is not free tier, will be charged - caution here)

Network & Subnet ==> Choose existing VPC & subnet (or) create new ones. It is recommended to run your Elasticsearch instance in a private subnet for security reason.

Storage ==>  30 GB gp2 EBS volume

Security Group 
- Security group must allow access to below ports:

Type: SSH

Protocol: TCP

Port Range: 22

Source: Give your IP

Type: Custom TCP

Protocol: TCP

Port Range: 9200

Source: Multi AZ Subnet IPv4 CIDR (This is required for ES node in one AZ to discover node running in another AZ)

Type: Custom TCP

Protocol: TCP

Port Range: 9300

Source: Multi AZ Subnet IPv4 CIDR (This is required for ES node in one AZ to discover node running in another AZ)


Key Pair ==> Create/use an existing key pair as we need to SSH later

IAM ==>  Create an IAM role with ec2:DescribeInstances permission as it required for EC2 discovery plugin to work


# Now Installating and deploying elasticsearch and other software , we are going to use Ansible for this.
site.yml  we run this files using ansible-playbook site.yml -K

# we created roles for elasticsearch & java and will also need to create roles for kibana, metricbeats , logstach etc in future.
 Under roles/tasks/main.yml we defined our requirement.
 
 # we also automate the creation of self-signed-certification to provide the security to the elasticsearch
  self-signed-cert.yml
  
 # to provide more security to our webpage we used nginx which acts as proxy and require to provide credential to access the page
 we updated the nginx configuration to acts a proxy

To create ngnix user credential , we should use below command
sudo htpasswd -c /etc/nginx/htpasswd.users <user_name>

it will prompt for password. Now this will be your user id and password to access the es server web page.

To create the AWS infrastructure, created the .tf files .
