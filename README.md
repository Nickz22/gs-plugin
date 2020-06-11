Guided Selling Helper
======

This Guided Selling sfdx plugin contains utility commands to make development easier. It can do things like initialize your scratch org, create bulk data or delete data (in your scratch org).

# Installation
1. [Install Salesforce Cli](https://developer.salesforce.com/tools/sfdxcli)
2. Clone this repository
  * `git clone https://github.com/Nickz22/gs-plugin.git`
3. `cd` into the repository directory
4. Run `sfdx plugins:link`
5. Confirm successful installation by running:
  * `sfdx gs --help`
  
# Commands
After completing the installation steps, you should be able to execute the following commands from your development sfdx project.
## sfdx gs:scratch:start -a {org_alias}
This command does the following: 
1. Initializes a scratch org.
2. Installs the RingDNA for Salesforce package.
3. Deploys Guided Selling source code to scratch org.
4. Creates password for scratch org user.
5. Assigns Sequence_Admin permission set to scratch org user.
6. TO DO::: Updates Lead, Contact and Sequence Action page layouts.

## sfdx gs:helper:data:{operation} -o {object_name}
This command works with [local .apex files in the Sequence repository](https://github.com/ringdna/sequence/tree/Sequence-QA/src/scripts/apex/data). Which .apex file gets executed depends on the command and flag you provide:
1. `sfdx gs:helper:data:insert -o (lead | l | contact | c | opportunitycontactrole | ocr)`
  * if flag is "lead" or "l", executes [src/scripts/apex/data/insert/leads.apex](https://github.com/ringdna/sequence/blob/Sequence-QA/src/scripts/apex/data/insert/leads.apex)
  * if flag is "contact" or "c", executes [src/scripts/apex/data/insert/contacts.apex](https://github.com/ringdna/sequence/blob/Sequence-QA/src/scripts/apex/data/insert/contacts.apex)
  * if flag is "opportunitycontactrole" or "ocr", executes [src/scripts/apex/data/insert/ocrs.apex](https://github.com/ringdna/sequence/blob/Sequence-QA/src/scripts/apex/data/insert/ocrs.apex)
2. `sfdx gs:helper:data:update -o (lead | l | contact | c )`
  * if flag is "lead" or "l", executes [src/scripts/apex/data/update/leads.apex](https://github.com/ringdna/sequence/blob/Sequence-QA/src/scripts/apex/data/update/leads.apex)
  * if flag is "contact" or "c", executes [src/scripts/apex/data/update/contacts.apex](https://github.com/ringdna/sequence/blob/Sequence-QA/src/scripts/apex/data/update/contacts.apex)
3. `sfdx gs:helper:data:delete -o (lead | l | contact | c )`
  * if flag is "lead" or "l", executes [src/scripts/apex/data/delete/leads.apex](https://github.com/ringdna/sequence/blob/Sequence-QA/src/scripts/apex/data/delete/leads.apex)
  * if flag is "contact" or "c", executes [src/scripts/apex/data/delete/contacts.apex](https://github.com/ringdna/sequence/blob/Sequence-QA/src/scripts/apex/data/delete/contacts.apex)
4. `sfdx gs:helper:data:bulk -o (lead | l )`
  * if flag is "lead" or "l", executes [src/scripts/apex/data/bulk/leads.apex](https://github.com/ringdna/sequence/blob/Sequence-QA/src/scripts/apex/data/bulk/leads.apex)
  
  
  ** Note ** 
  You shouldn't have to worry about other developers overwriting your .apex files since the scripts/apex/data directory is in [.gitignore](https://github.com/ringdna/sequence/blob/48f3aa22143ace7be66170fc2d8145d59c90d7fb/src/.gitignore#L47).
