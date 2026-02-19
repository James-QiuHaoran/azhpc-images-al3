#!/bin/bash

set -ex

sudo chown -R $USER:$USER /mnt/azureuser/
az storage blob download --account-name hqiublobstorage --container-name azure-linux-prebuilt --name azlinux_hpc_test_rpms_x86_64_0.0.17.tar.gz --file azlinux_hpc_test_rpms_x86_64_0.0.17.tar.gz --auth-mode login
tar -xvf "./azlinux_hpc_test_rpms_x86_64_0.0.17.tar.gz"
mv prebuilt azhpc-images-al3/
cd /mnt/azureuser/azhpc-images-al3/distros/azurelinux3.0
sudo ./install.sh NVIDIA Standard_ND96ams_A100_v4
