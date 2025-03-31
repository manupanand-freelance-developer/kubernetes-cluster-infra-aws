output "aws_control_plane_private_ip" {
  value = aws_instance.instance_control_plane.private_ip
}
output "control_plane_security_group_id" {
  value = aws_security_group.kube_control_plane.id
}