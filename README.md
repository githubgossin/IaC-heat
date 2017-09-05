# IaC-heat
Heat templates for the NTNU course [Infrastructure as Code (IaC)](https://www.ntnu.edu/studies/courses/IMT3005).

Your keypair must be provided in `iac_top_env.yaml` and two security groups (in addition to the default group): `linux` and `windows` should exist.

`iac_base` creates the servers `manager`, `monitor` and `dir01` (ad/dns), and two networks: `admin` and `internal`. 
`iac_rest_1` (which depends on `iac_base`) creates some servers with interfaces in both networks. Create stack with e.g.

```bash
openstack stack create iac -t iac_top.yaml -e iac_top_env.yaml
```
