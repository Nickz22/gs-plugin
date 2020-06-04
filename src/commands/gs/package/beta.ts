import { flags, SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";
import { doAction } from "../../../Util/Util";

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);
// console.log('here');
// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("helper", "beta"); 

export default class Beta extends SfdxCommand {
  public static description = messages.getMessage('commandDescription');

  protected static flagsConfig = {
    alias: flags.string({
      char: "u",
      description: messages.getMessage("packagingOrgDescription") // not sure how to use the messages object yet...
    })
  };
  public async run(): Promise<AnyJson> {
    if( this.flags.alias == undefined ){
      console.log("please provide the packaging org alias in the -u parameter");
      return;
    }

    const inputValidation = () => {
      console.log('validating input ts');
      const validateCommand : string = `bash scripts/bash/validate.sh ${this.flags.alias}`;
      doAction(validateCommand, authorize)
    }
    const authorize = () => {
      console.log('authorizing');
      const authCommand : string = `bash scripts/bash/auth.sh`; 
      doAction(authCommand, deployToPackagingOrg);
    }
    const deployToPackagingOrg = () => {
      console.log('deploying');
      const deployCommand : string = `bash scripts/bash/deployToPkgOrg.sh ${this.flags.alias}`
      doAction(deployCommand, createBetaPackage);
    }
    const createBetaPackage = () => {
      console.log('creating beta');
      const betaCommand : string = `bash scripts/bash/createbeta.sh ${this.flags.alias}`
      doAction(betaCommand, () => {return "done";});
    }

    inputValidation();
    // return "done";
  }
  
}
