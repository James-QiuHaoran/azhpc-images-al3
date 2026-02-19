#!/bin/bash

set -ex

# Ensure directory ownership
sudo chown -R $USER:$USER /mnt/azureuser/

# Determine Auth Parameters
# If SAS_TOKEN is set, use it. Otherwise, fall back to login mode.
if [ -n "$SAS_TOKEN" ]; then
    AUTH_PARAMS="--sas-token $SAS_TOKEN"
    echo "Using SAS Token for authentication."
else
    AUTH_PARAMS="--auth-mode login"
    echo "SAS_TOKEN not set, falling back to --auth-mode login."
fi

# Download the blob
az storage blob download \
    --account-name hqiublobstorage \
    --container-name azure-linux-prebuilt \
    --name azlinux_hpc_test_rpms_x86_64_0.0.17.tar.gz \
    --file azlinux_hpc_test_rpms_x86_64_0.0.17.tar.gz \
    $AUTH_PARAMS

# Extract and install
tar -xvf "./azlinux_hpc_test_rpms_x86_64_0.0.17.tar.gz"
cd /mnt/azureuser/azhpc-images-al3/distros/azurelinux3.0
sudo ./install.sh NVIDIA Standard_ND96ams_A100_v4
