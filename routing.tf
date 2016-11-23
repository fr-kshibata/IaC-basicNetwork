

# Grant the VPC internet access on its main route table using default route
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default-igw.id}"
}

# Create a routing table for NAT and Private subnet
resource "aws_route_table" "private_subnet_nat" {
  vpc_id				         	 = "${aws_vpc.main.id}"

	/*route = {
		cidr_block 						 = "${aws_vpc.main.cidr_block}"
  	nat_gateway_id         = "${aws_nat_gateway.gw.id}"
	}*/
	tags = {
		Name = "${var.pre_tag}-${var.service_name}-private-route"
	}
	/*depends_on = ["aws_nat_gateway.gw"]*/
}

resource "aws_route" "private_subnet_dest" {
	route_table_id	= "${aws_route_table.private_subnet_nat.id}"
	destination_cidr_block = "0.0.0.0/0"
	depends_on = ["aws_route_table.private_subnet_nat"]
}
