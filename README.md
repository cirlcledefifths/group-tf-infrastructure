# Metwork DuploCloud Terraform

Prerequisites:
* [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). [tfenv](https://github.com/tfutils/tfenv?tab=readme-ov-file#installation) can be helpful for this.
* [Install `duploctl`](https://cli.duplocloud.com/Installation/)
* Set a `DUPLO_TOKEN`:

    ```
    export DUPLO_TOKEN=$(duploctl --host "https://duplo.preprod.cloud.metwork.com" --admin --interactive jit token --query token --output string)
    ```
* Configure an [AWS profile pointing to the portal](https://cli.duplocloud.com/Jit/#duplo_resource.jit.DuploJit.aws) (required by Terraform backends):
    ```
    [profile duplo.preprod.cloud.metwork.com]
    region=us-east-2
    output=json
    credential_process=duploctl --host "https://duplo.preprod.cloud.metwork.com" --admin --interactive jit aws
    ```
* Set that AWS profile:
    ```
    export AWS_PROFILE=duplo.preprod.cloud.metwork.com
    ```

Then you can run terraform from the directory that represents the resources you want to update:
```
cd terraform/portals/duplo.preprod.cloud.metwork.com/infrastructures/nonprod01/tenants/tfdemo01/app
terraform init # Only required on first run or when making changes to things like providers and backends.
terraform plan
```
