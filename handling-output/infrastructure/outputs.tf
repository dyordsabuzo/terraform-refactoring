output "images" {
  value = docker_registry_image.image
}

output "worker_image_name" {
  value = docker_registry_image.image[index(var.repository_list, "worker")].name
}

output "worker_image" {
  value = docker_registry_image.image[index(var.repository_list, "worker")]
}
