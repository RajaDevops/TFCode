provider "aws" {
 
}

variable "cidr_block" {
    description = "cidr blocks"
	type = list(string)
}


resource "aws_vpc" "dev-vpc" {
    #cidr_block = "10.0.0.0/16"
	cidr_block = var.cidr_block[1]
    tags = {
        Name: "newaxis"
            }
}   


resource "aws_subnet" "dev-subnet" {
    vpc_id = aws_vpc.dev-vpc.id
    #cidr_block = "10.0.10.0/24"
    cidr_block = var.cidr_block[0]
    availability_zone = "ap-south-1a"
    tags = {
        Name: "newaxis-subnet"
            }
}

data "aws_vpc" "existing-vpc" {
    default = true    
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = data.aws_vpc.existing-vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "ap-south-1a"
    tags = {
        Name: "default-subnet"
    }
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id
}

output "dev-subnet-id" {
        value = aws_subnet.dev-subnet.cidr_block
}

output "dev-subnet-block" {
        value = aws_subnet.dev-subnet-1.id
}
