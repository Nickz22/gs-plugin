import { flags, SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";
const { exec } = require("child_process");

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);

// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("gs-plugin", "helper");

export default class Data extends SfdxCommand {
  protected static flagsConfig = {
    operation: flags.string({
      char: "o",
      description: messages.getMessage("operationFlagDescription"),
    }),
    object: flags.string({
      char: "n",
      description: messages.getMessage("objectFlagDescription"),
    }),
  };
  public async run(): Promise<AnyJson> {
    const command = "sfdx force:apex:execute -f src/commands/helper/apex";
    switch (this.flags.object) {
      case "contact":
      case "c":
        doContactAction(this.flags.operation);
        break;
      case "ocr":
      case "opportunitycontactrole":
        doOcrAction(this.flags.operation);
        break;
      case "lead":
      case "l":
        doLeadAction(this.flags.operation);
        break;
    }
    function doContactAction(operation: string) {
      switch (operation) {
        case "delete":
        case "d":
          doAction(`${command}/deleteContacts.apex`);
          break;
        case "insert":
        case "i":
          doAction(`${command}/deleteContacts.apex`);
          break;
        case "update":
        case "u":
          doAction(`${command}/deleteContacts.apex`);
          break;
        case "b":
        case "bulk":
          console.log("no bulk action available for Contact");
      }
    }
    function doLeadAction(operation: string) {
      switch (operation) {
        case "delete":
        case "d":
          doAction(`${command}/deleteLeads.apex`);
          break;
        case "insert":
        case "i":
          doAction(`${command}/insertLeads.apex`);
          break;
        case "update":
        case "u":
          doAction(`${command}/updateLeads.apex`);
          break;
        case "b":
        case "bulk":
          doAction(`${command}/bulkTestLead.apex`);
          break;
      }
    }
    function doOcrAction(operation: string) {
      switch (operation) {
        case "delete":
        case "d":
          console.log("no delete action for ocrs");
          break;
        case "insert":
        case "i":
          doAction(`${command}/insertOcrs.apex`);
          break;
        case "update":
        case "u":
          console.log("no update action for ocrs");
          break;
        case "b":
        case "bulk":
          console.log("no bulk action available for OpportunityContactRole");
      }
    }

    function doAction(command: string) {
      exec(command, (err, stdout, stderr) => {
        if (stdout) console.log("RESPONSE \n " + stdout);
        if (stderr) {
          if (stderr.includes("OAuth")) {
            console.log(
              "Please run sfdx force:config:set defaultusername=your_alias"
            );
          } else console.log("ERROR \n" + stderr);
        }
      });
    }
    return "done";
  }
}
