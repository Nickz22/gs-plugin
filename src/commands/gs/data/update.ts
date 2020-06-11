import { flags, SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";
import { doAction } from "../../../Util/Util";

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);

// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("helper", "updateData");

export default class Data extends SfdxCommand {
  public static description = messages.getMessage("commandDescription");

  protected static flagsConfig = {
    operation: flags.string({
      char: "o",
      description: messages.getMessage("objectFlagDescription"),
    }),
  };
  public async run(): Promise<AnyJson> {
    const command = "sfdx force:apex:execute -f scripts/apex/data/update";
    switch (this.flags.object) {
      case "contact":
      case "c":
        doAction(`${command}/contacts.apex`);
        break;
      case "ocr":
      case "opportunitycontactrole":
        doAction(`${command}/ocrs.apex`);
        break;
      case "lead":
      case "l":
        doAction(`${command}/leads.apex`);
        break;
    }
    return "done";
  }
}
