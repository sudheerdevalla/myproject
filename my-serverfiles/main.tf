resource "aws_instance""test-server" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = "myswathi"
  vpc_security_group_ids = ["sg-085d397fd5b74002f"]
  connection
  {
     type               = "ssh"
     user               = "ubuntu"
     private_key        = file(".myswathi.pem")
     host               = self.public_ip
  }
  provisioner "remote-exec" 
  {
      inline = ["echo 'wait to start the instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
      inline - " echo ${aws_instance.test-server.public_ip} > invntory "
  }
  provisioner "local-exec" {
      command - "ansible-playbook /var/lib/jenkins/workspace/maybank/my-serverfiles/finance-playbook.yml"
  }
}
  
      
