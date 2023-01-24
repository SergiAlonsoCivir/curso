provider "aws" {
region = "us-east-1"
}
resource "aws_instance" "sergi-server" {
ami = "ami-00874d747dde814fa"
instance_type = "t2.micro"

    tags = {
        Name = "Sergi-terraformer"
    }

user_data= <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p 8080 & 
    EOF

user_data_replace_on_change = true

vpc_security_group_ids = [aws_security_group.allow_web.id]
  
}
   


resource "aws_security_group" "allow_web" {
    ingress  {
      
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
     
      
    } 
  
}



