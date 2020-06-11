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
  
## Contributing
You can add new commands to an existing or new namespace. For example, you can add a "user" namespace to the "gs" namespace (gs:user), or add a new command to the existing "gs:data" namespace.
### Add new command to existing namespace
1. Create new .ts file under the directory matching the namespace.
  * If you want your new "explode" command to live under the "data" namespace, you'll add `explode.ts` within the `src/commands/gs/data` directory
2. Add a new .json file to the `messages` top level directory.
  * Name doesn't matter but it's best to keep it similar to the .ts file name.
3. Copy the typescript from some other command like `src/commands/gs/data/insert.ts` to get the necessary boilerplate.
4. Edit`const messages = Messages.loadMessages("helper", "updateData");` so that the second parameter to `Messages.getMessages()` matches the name of your new .json file from (2)
5. Add or change the name of the existing `protected static flagsConfig` property to the desired character and description of your command flag(s).
6. To execute an apex script, use `doActionWithCallback()` to execute `sfdx force:apex:execute -f {path_to_apex_script}`, and then execute some function callback.
  * Any apex scripts for this plugin should be placed in the [src/scripts/apex/data/](https://github.com/ringdna/sequence/tree/Sequence-QA/src/scripts/apex/data) directory and follow the same directory structure as existing commands
7. To commit your new .apex file:
  * Temporarily comment out  `scripts/apex/data/` in [.gitignore](https://github.com/ringdna/sequence/blob/48f3aa22143ace7be66170fc2d8145d59c90d7fb/src/.gitignore#L47)
  * commit your .apex files
  * push to remote
  * discard your .gitignore changes
### Add new plugin namespace
1. Add a new directory within `commands/gs` whose name matches your intended namespace.
2. Follow [the above steps](https://github.com/Nickz22/gs-plugin/blob/master/README.md#add-new-command-to-existing-namespace) to add a command to the namespace.
 
 ### Notes
 
1. You shouldn't have to worry about other developers overwriting your .apex files since the scripts/apex/data directory is in [.gitignore](https://github.com/ringdna/sequence/blob/48f3aa22143ace7be66170fc2d8145d59c90d7fb/src/.gitignore#L47).
2. To use commands you've just added, you'll need to run `sfdx plugins:link` to update the sfdx-namespaced plugin references.
 
