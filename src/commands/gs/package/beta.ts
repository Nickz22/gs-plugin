import { flags, SfdxCommand } from "@salesforce/command";
import { Messages } from "@salesforce/core";
import { AnyJson } from "@salesforce/ts-types";
import { doActionWithCallback, createNewVersion, log } from "../../../Util/Util";

// Initialize Messages with the current plugin directory
Messages.importMessagesDirectory(__dirname);
// console.log('here');
// Load the specific messages for this file. Messages from @salesforce/command, @salesforce/core,
// or any library that is using the messages framework can also be loaded this way.
const messages = Messages.loadMessages("helper", "beta"); 

export default class Beta extends SfdxCommand {
  public static description = messages.getMessage('commandDescription');

  commands = {
    validate: 'bash scripts/bash/validateInput.sh',
    version: 'bash scripts/bash/createBetaVersion.sh',
    install: 'bash scripts/bash/qaInstall.sh',
    initdata: 'bash scripts/bash/createTestData.sh'
  };

  protected static flagsConfig = {
    alias: flags.string({
      char: "u",
      description: messages.getMessage("packagingOrgDescription")
    })
  };
  public async run(): Promise<AnyJson> {
    if( this.flags.alias == undefined ){
      log(messages.getMessage("preValidateMessage"));
      return;
    }

    const inputValidation = () => {
      doActionWithCallback(`${this.commands.validate} ${this.flags.alias}`, createBetaVersion);
    }
    const createBetaVersion = () => {
      log(messages.getMessage("beginNewVersion"));
      log('installing in QA');
      log('...then create test data');
      createNewVersion(`${this.commands.version} ${this.flags.alias}`, () => {console.log('done installing in QA...')});
    }
    // const installInQa = (versionId : string) => {
    //   log(messages.getMessage("installNewVersion"));
    //   doPackageInstall(`${this.commands.install} ${versionId}`, createTestData);
    // }
    // const createTestData = () => {
    //   log(messages.getMessage("createTestData"));
    //   doActionWithCallback(this.commands.initdata, () => {return});
    // }

    inputValidation();
    return "done";
  }
}
