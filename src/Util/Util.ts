const { exec } = require("child_process");

export async function doActionWithCallback(command: string, callback: any) {
  let success : boolean = true;
  await exec(command, (err, stdout, stderr) => {
    if (err){
      success = false;
      console.log("ERROR");
      return success;
    }
    if (stdout){
      if(stdout != null && stdout.length > 0){
        console.log(stdout);
        callback();
      }else{
        console.log('empty std out...');  
      }
    }
  });
  return success;
}

export function doPackageUpload(command: string, callback: any){
  exec(command, (err, stdout, stderr) => {
    if (stderr) {
      console.log(stderr);
      console.log('oops, looks like an error occurred in the packaging comand\nplease reach out to Nick for assistance');
      return;
    }
    if (err) {
      console.log(err);
      console.log('oops, looks like an error occurred in the packaging comand\nplease reach out to Nick for assistance');
      return;
    }
    if (stdout){
      if( stdout.includes('__PACKAGEID__') ){
        console.log('successfully uploaded new package version...');
        let versionId = stdout.substring(stdout.indexOf('__PACKAGEID__')+13);
        console.log('extracted id ==> '+versionId);
        callback(versionId);
      }else{
        console.log(stdout);
        console.log('<=== stdout package upload else ===>');
      }
    }
  });
}

export function doPackageInstall(command: string, callback: any){
  console.log('package install command: '+command);
  exec(command, (err, stdout, stderr) => {
    if (stderr) {
      if( stderr.includes('You cannot upgrade a beta package') ){
        console.log('Please uninstall Sequence QA package and try again.')
        return;
      }
      console.log('oops, error occurred while installing in QA :::');
      console.log(stderr);
      console.log('please reach out to Nick for assistance');
    }
    if (err) {
      console.log(err);
      if( err.includes('You cannot upgrade a beta package') ){
        console.log('Please uninstall Sequence QA package and try again.')
        return;
      }
      console.log('oops, error occurred while installing in QA :::');
      console.log(stderr);
      console.log('please reach out to Nick for assistance');
    }
    if (stdout){
      if( stdout.includes('Successfully') ){
        console.log('successfully installed beta package in QA...');
        callback();
      }
    }
  });
}

export function doAction(command: string){
  exec(command, (err, stdout, stderr) => {
    if (stderr) {
      if (stderr.includes("OAuth")) {
        console.log(
          "Please run sfdx force:config:set defaultusername=your_alias"
        );
      }else if(stderr.includes('No such file')){
        console.log(stderr);
        console.log('HINT: Please cd into the "src" dir of the git repo before using plugin');
      }else console.log(stderr);
    }
    if (stdout){
      console.log(stdout);
    }
  });
}

export function log(output: any){
  console.log(output);
}
