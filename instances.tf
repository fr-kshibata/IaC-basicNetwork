provider "aws" {
    region = "${var.region}"
}

resource "aws_instance" "public_instance" {
	ami = "${lookup(var.amazon_amis, var.region)}"

	tags = {
		Name = "${var.pre_tag}-${var.service_name}-${var.post_tag}"
		env = "${var.env_tag}"
	}

	instance_type = "${var.instance_type}"
	ebs_optimized = "${var.ebs_optimized}"
	key_name = "${var.key_pair}"
	subnet_id = "${aws_subnet.public_primary.id}"
	associate_public_ip_address = true
}


resource "aws_instance" "private_instance" {
	ami = "${lookup(var.amazon_amis, var.region)}"

	tags = {
		Name = "${var.pre_tag}-${var.service_name}-${var.post_tag}"
		env = "${var.env_tag}"
	}

	instance_type = "${var.instance_type}"
	ebs_optimized = "${var.ebs_optimized}"
	key_name = "${var.key_pair}"
	subnet_id = "${aws_subnet.private_primary.id}"
	associate_public_ip_address = false
}
