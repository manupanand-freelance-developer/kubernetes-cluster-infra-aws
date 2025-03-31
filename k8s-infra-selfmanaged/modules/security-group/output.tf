output "control_plane_security_group" {
  value= aws_security_group.kube_control_plane.id
}
output "worker_security_group" {
  value = aws_security_group.kube_worker.id
}