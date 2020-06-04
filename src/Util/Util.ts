const { exec } = require("child_process");

export async function doAction(command: string, callback: any) {
  let success : boolean = true;
  await exec(command, (err, stdout, stderr) => {
    if (stdout){
      console.log('stdout!!'); 
      console.log(stdout);
      callback();
    }
    if (stderr) {
      console.log('error');
      success = false;
      if (stderr.includes("OAuth")) {
        console.log(
          "Please run sfdx force:config:set defaultusername=your_alias"
        );
      }else if(stderr.includes('No such file')){
        console.log(stderr);
        console.log('HINT: Please cd into the "src" dir of the git repo before using plugin');
      }else console.log(stderr);
    }
  });
  return success;
}
