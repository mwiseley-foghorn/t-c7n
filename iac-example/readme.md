# Terraform

## Folder Hierarchy
The terraform directory houses all terraform code. There are three top level folders, each with a specific purpose:

### environments
These align directly with terraform states. Each subfolder in this folder is associated with it's own terraform state, and can be managed independently from other subfolders.  At a minimum, we should be partitioning the state of development from staging, and from production. Additionally, we may want to partition further, depending on job responsibilities. For instance, if networking is managed by a separate team, we may want our VPC infrastructure for each environment to be partitioned.  Often there are resources that all environments depend on, which need to exist prior to any environment. these can all live in a single state, like `common`. Ideally, each environment will call a single service. The difference between environments is simply the variables passed to the service module.  The enviromment terraform should have very minimal code/logic.  Variables, State, Data, Module Declarations, and outputs only.

### services
This folder contains our large services that we want multiple instances of.  Services are aggregations of resource modules, and in some events, individual resource calls.  These are blocks of infrastructure that accomplish a business function, and you are intending to spin up multiple instances of.  Services are called by environments, and call resources, either resource modules or straight resource calls.  Each service should be a standalone, with perhaps some dependendcies on some shared infrastucture environment, like 'common'.  In the service module usage, the module is instantiating other modules (resources).

### resources
This folder contains our re-useable sets of resources. Each subfolder in this folder is a terraform module.  These should take variables as inputs, and offer back required outputs.  There should not be anything in a module that makes it unique to a specific environment, and there should not be dependencies on other modules. If we feel the need to nest modules here, we may be building a service module, not a resource module.  Refer to items created elsewhere via the `terraform_remote_state` data resource.  Each resource module may be used by many services and many environments.  In the resources module usage, the modules are managing like resources.  Resources which are instantiated by the service module should be:

* simple
* flat (no nested modules)
* pure (like a function)
* cohesive (resources related to the same part of the service should be grouped together)
* decoupled (no dependencies on other modules, only their variables and MAYBE limited data sources)

## Anti Patterns
The following highlights some anti-patterns to the above that should be avoided.

* a module which creates an individual resource or small group of resources which expose every option as a configuration point

    Why?  Becase modules are an abstraction and should be used that way

* resource modules which instantiate other resource modules
    
    Why?

    * state file gets complex as do resource paths (pre TF 0.12)
    * refactoring is difficult
    * complexity spirals out of control

    Rule: only the service (root) module should instantiate other modules

This includes the opinions of [hashidays-nyc](https://github.com/jen20/hashidays-nyc)