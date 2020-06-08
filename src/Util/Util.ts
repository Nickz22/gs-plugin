const { exec } = require("child_process");
const genericError : string = 'oops, looks like an error occurred while';
const messages = {
  packagingError : `${genericError} creating a new package version`,
  installError : `${genericError} installing the new version in QA`,
  packageIdPhrase : '__PACKAGEID__',
  successNewVersion : 'successfully uploaded new package version...',
  installingNewVersion : 'installing new version in QA ==> ',
  successInstall : 'successfully installed beta package in QA...',
  betaUpgradeError : 'You cannot upgrade a beta package',
  betaUpgradeHint : 'Please uninstall Sequence QA package and try again'
}

export async function doActionWithCallback(command: string, callback: any) {
  let success : boolean = true;
  await exec(command, (err, stdout, stderr) => {
    if (err){
      success = false;
      log("ERROR");
      return success;
    }
    if (stdout){
      if(stdout != null && stdout.length > 0){
        log(stdout);
        callback();
      }else{
        log('empty std out...');  
      }
    }
  });
  return success;
}

export function createNewVersion(command: string, callback: any){
  exec(command, (err, stdout, stderr) => {
    if (stderr) {
      log(stderr);
      log(messages.packagingError);
      return;
    }
    if (err) {
      log(err);
      log(messages.packagingError);
      return;
    }
    if (stdout){
      if( stdout.includes(messages.packageIdPhrase) ){
        log(messages.successNewVersion);
        let versionId = stdout.substring(stdout.indexOf(messages.packageIdPhrase)+messages.packageIdPhrase.length);
        log(`${messages.installingNewVersion} ${versionId}`);
        callback(versionId);
      }else{
        log(stdout);
        log('<=== stdout package upload else ===>');
      }
    }
  });
}

export function doPackageInstall(command: string, callback: any){
  exec(command, (err, stdout, stderr) => {
    if (stderr) {
      if( stderr.includes(messages.betaUpgradeError) ){
        log(messages.betaUpgradeHint);
        return;
      }
      log(messages.installError);
      log(stderr);
    }
    if (err) {
      log(err);
      if( err.includes(messages.betaUpgradeError) ){
        log(messages.betaUpgradeHint);
        return;
      }
      log(messages.installError);
      log(stderr);
    }
    if (stdout){
      if( stdout.includes('Success') || stdout.includes('success') ){
        log(messages.successInstall);
        callback();
      }
    }
  });
}

export function doAction(command: string){
  exec(command, (err, stdout, stderr) => {
    if (stderr) {
      if (stderr.includes("OAuth")) {
        log(
          "Please run sfdx force:config:set defaultusername=your_alias"
        );
      }else if(stderr.includes('No such file')){
        log(stderr);
        log('HINT: Please cd into the "src" dir of the git repo before using plugin');
      }else log(stderr);
    }
    if (stdout){
      log(stdout);
    }
  });
}

export function log(output: any){
  console.log(output);
}
