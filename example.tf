provider "aws" {
  region     = var.region
}
resource "aws_instance" "example" {
  ami           = var.amis[var.region]
  instance_type = "t2.micro"

    tags = {
    Name = "Sushome-ec2"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
  # depends_on = [aws_s3_bucket.example]
}

resource "aws_instance" "another" {
  ami           = var.amis[var.region]
  instance_type = "t2.micro"

  tags = {
    Name = "Sushome-2-ec2"
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}

# resource "aws_s3_bucket" "example" {
#   # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
#   # this name must be changed before applying this example to avoid naming
#   # conflicts.
#   bucket = "terraform-getting-started-sus"
#   acl    = "private"
# }