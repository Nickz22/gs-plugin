import { SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";
import { doAction } from "../../../Util/Util";

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);
// console.log('here');
// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("helper", "release"); 

export default class Beta extends SfdxCommand {
  public static description = messages.getMessage('commandDescription');

  commands = {
    newRelease: 'sfdx force:package1:version:create -u pkgOrg -m  --name GuidedSelling --packageid 0336F000000B3Oh'
  };
  public async run(): Promise<AnyJson> {
    doAction(this.commands.newRelease);
    return "done";
  }
}
