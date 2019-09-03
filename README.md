# IaC-heat
Heat template for the NTNU course [Infrastructure as Code (IaC)](https://www.ntnu.edu/studies/courses/IMT3005).

This template demonstrates five important features of orchestration setup:
* Nested stack
* Sequencing: having one substack (`iac_base`) complete before the next one (`iac_rest`) is launched
* Passing information from one substack (`manager_ip_address`) to another
* Including startup scripts (in the lib directory) which use data from Heat (`manager_ip_address`)
* Iteration and variables: creating lin01 and lin02, win og lin 

Your keypair must be provided in `iac_top_env.yaml` and two security groups (in addition to the default group): `linux` and `windows` should exist.

`iac_base` creates the server `manager`, and the network infrastructure. 
`iac_rest` (which depends on `iac_base`) creates dir (for config registry, DNS, etc), mon (for monitoring), and some clients for testing: win, lin and test

This stack uses 40GB RAM and 16 vcpus by default.

Create stack with e.g.
```bash
openstack stack create iac -t iac_top.yaml -e iac_top_env.yaml
```
