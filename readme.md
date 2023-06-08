## Step 0: Clone the script and move to the folder

Clone the repository containing the necessary script and navigate to the appropriate directory.

```
git clone https://github.com/sunil-9/terraform-with-shell.git
cd terraform-with-shell
```

## Step 1: Run the Docker image

Run the Docker image with the code on the Docker machine, using the `-v` argument to mount volumes. Enter the Docker machine.

**for `linux` and `powerShell`**
```
docker run -it --rm  -v ${PWD}:/work -w /work  alpine sh
```

**for `windows cmd`**
```
docker run -it --rm -v "%cd%":/work -w /work ubuntu sh
```
## Step 2: Install dependencies

Since you are using Ubuntu, you need to install `curl` and `terraform`.

```
apt-get update
apt-get install -y curl terraform
```

Note : if terraform didnot get installed your can install Terraform, following the official installation instructions for Ubuntu: https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#install-terraform

## Step 3: Give execution permission to the script

Make the script executable by granting execution permission.

```
chmod +x install.sh
```

## Step 4: Run the script

Execute the installation script.

```
./install.sh
```

