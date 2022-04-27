locals {
  images = {
    for key, value in module.ecr_image.images :
    key => value.name
  }
}
