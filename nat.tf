# Creating Nat Gateway
resource "aws_eip" "nat" {
vpc = true
}
resource "aws_nat_gateway" "nat-gw" {
allocation_id = aws_eip.nat.id
subnet_id     = aws_subnet.My-public-1.id
depends_on    = [aws_internet_gateway.My-igw]
}
# Add routes for VPC
resource "aws_route_table" "My-private" {
vpc_id = aws_vpc.project-5.id
route {
cidr_block     = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.nat-gw.id
}
tags = {
Name = "My-private-1"
}
}
# Creating route associations for private Subnets
resource "aws_route_table_association" "My-private-1-a" {
subnet_id      = aws_subnet.My-private-1.id
route_table_id = aws_route_table.My-private.id
}
resource "aws_route_table_association" "My-private-2-a" {
subnet_id      = aws_subnet.My-private-2.id
route_table_id = aws_route_table.My-private.id
}