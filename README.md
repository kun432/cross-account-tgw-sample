# cross-account-tgw

クロスアカウントのVPCをTransit Gatewayで接続するTerraformサンプルです。

## Usage

### tfstate用S3バケットの作成

ownerとuserのアカウントでそれぞれtfstate用S3バケットを作成しておく。バケット名は適宜変更。

- envs/owner/backend.tf

```
    bucket = "foobar-owner"
```

- envs/user/backend.tf

```
    bucket = "foobar-user"
```

### owner

envs/owner/variable.tfを修正

- owner側VPCのCIDR
- userアカウントID
- user側VPCのCIDR

```
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "user_account" {
  default = "222222222222"
}

variable "user_vpc_cidr" {
  default = "10.10.0.0/16"
}
```

terraform実行

```
$ cd envs/owner
$ terraform init
$ terraform apply
```

### user

envs/owner/variable.tfを修正

- owner側VPCのCIDR
- userアカウントID
- user側VPCのCIDR

```
variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "owner_account" {
  default = "111111111111"
}

variable "owner_vpc_cidr" {
  default = "10.0.0.0/16"
}
```

terraform実行

```
$ cd envs/user
$ terraform init
$ terraform apply
```

## ToDo

- [ ] securty groupの追加