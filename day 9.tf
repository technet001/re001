provider "aws" {
    region = "ap-southeast-1"
  
}

resource "aws_instance" "web" {
  ami           = "ami id"
  instance_type = "t2.micro"
  key_name = "terraform.pem"

  provisioner "file" {
    source      = "local.yml"
    destination = "/home/ec2-user/local.yml"
  }
  connection {
    type     = "ssh"
    user     = "root"
    private_key = "${file(terraform.pem)}"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "yum install git -y",
      "yum install python -y",
     ]
  }
}
 
resource "aws_vpc" "test_vpc" {
  cidr_block       = "192.168.1.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "test_vpc"
  }
}

 


  

 