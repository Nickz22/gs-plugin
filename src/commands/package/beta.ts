import { flags, SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";
import { doAction } from "../../Util/Util";

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);

// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("helper", "package"); 

export default class Beta extends SfdxCommand {
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
    
    const command : string = `bash scripts/createbeta.sh ${this.flags.alias}`
    doAction(command);
    return "done";
  }
}
