import { flags, SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);

// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("helper", "packagecommand"); 

export default class Beta extends SfdxCommand {
  public static description = messages.getMessage('commandDescription');

  public async run(): Promise<AnyJson> {
    return "done";
  }
}
