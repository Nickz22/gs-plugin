import { flags, SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";
import { doAction, doActionWithCallback } from "../../../Util/Util";

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);

// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("helper", "deleteData");

export default class Delete extends SfdxCommand {
  public static description = messages.getMessage("commandDescription");

  protected static flagsConfig = {
    object: flags.string({
      char: "o",
      description: messages.getMessage("objectFlagDescription"),
    }),
  };
  public async run(): Promise<AnyJson> {
    const command = "sfdx force:apex:execute -f scripts/apex/data/delete";
    switch (this.flags.object) {
      case "contact":
      case "c":
        doActionWithCallback(`${command}/contacts.apex`, () => {
          return;
        });
        break;
      case "ocr":
      case "opportunitycontactrole":
        doActionWithCallback(`${command}/ocrs.apex`, () => {
          return;
        });
        break;
      case "lead":
      case "l":
        doActionWithCallback(`${command}/contacts.apex`, () => {
          return;
        });
        break;
    }
    return "done";
  }
}
