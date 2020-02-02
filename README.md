# Minecraft Platform

This is a collection of various templates to build a minecraft server in google
cloud platform (GCP).

To build this project you will need java, terraform, and packer installed. 
Beware following this guide will require a GCP account and money or compute
credits to pay for the cloud infrastructure.

Steps are still messy but should be fixed soon(tm)
1. build the packages via 
    ```
    cd packages
    ./gradlew clean build
    ```
2. go to the terraform folder and create the initial plan
    ```
    cd terraform
    terraform plan -target=google_storage_bucket_object.prometheus \
        -deb -target=google_storage_bucket_object.minecraft-server-deb
    ```
    The target args prevent terraform trying to provision images that don't
    exist yet
3. now run `terraform apply` to create the bucket and upload the deb packages

4. now that the packages are uploaded we can create the images via packer
    ```
    cd images/base-debian-10
    packer build base.json
    ```
    This creates a base image to build prometheus and minecraft. 

5. The output should have a line saying what the image name is for the base 
    image in the form of debian-10-base-########. You want to copy and paste 
    that image name into the prometheus and minecraft templates at the 
    `source_image` argument

6. now build the other images 
    ```
    cd images/minecraft
    packer build minecraft.json
    cd images/minecraft
    packer build prometheus.json
    ```
7. with the images created take the image names of the prometheus and minecraft
    images and insert that into the `terraform/compute-infra.tf` file in the
    `data` blocks at the top for the minecraft and prometheus images

8. when everything is done run 
   ```
   terraform plan
   terraform apply
   ```
   you should have a running minecraft server running in your GCP project