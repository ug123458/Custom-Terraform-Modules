```
module "vm" {
  source = "github.com/ug123458/Resouce-group-tf-module.git?ref=vm"
  prefix = "my-test-module"
}
```

It creates a basic linux vm with a public ip and password is Password1234! you need to provide providers.tf file.
