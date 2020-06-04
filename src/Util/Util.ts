const { exec } = require("child_process");

export async function doActionWithCallback(command: string, callback: any) {
  let success : boolean = true;
  await exec(command, (err, stdout, stderr) => {
    if (stderr) {
      success = false;
      if (stderr.includes("OAuth")) {
        console.log(
          "Please run sfdx force:config:set defaultusername=your_alias"
        );
      }else if(stderr.includes('No such file')){
        console.log(stderr);
        console.log('HINT: Please cd into the "src" dir of the git repo before using plugin');
      }else console.log(stderr);
      return success; // need to return because 
                        // std out is being run 
                          // in error outcomes
    }
    if (stdout){
      console.log(stdout);
      callback();
    }
  });
  return success;
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
