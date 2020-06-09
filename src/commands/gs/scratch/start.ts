import { flags, SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";
import { doAction, log, doActionWithCallback } from "../../../Util/Util";

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);
// console.log('here');
// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("helper", "scratch"); 

export default class Beta extends SfdxCommand {
  public static description = messages.getMessage('commandDescription');

  commands = {
    initScratchOrg: 'bash scripts/bash/initdevorg.sh'
  };

  protected static flagsConfig = {
    alias: flags.string({
      char: "a",
      description: messages.getMessage("orgAlias")
    })
  };
  public async run(): Promise<AnyJson> {
    if( this.flags.alias == undefined ){
      log(messages.getMessage("preValidateMessage"));
      return;
    }

    const initScratchOrg = () => {
        console.log(messages.getMessage("startingMessage"));
      doActionWithCallback(`${this.commands.initScratchOrg} ${this.flags.alias}`, () => {return;});
    }

    initScratchOrg();
    return "done";
  }
}
