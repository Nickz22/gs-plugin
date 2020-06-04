const { exec } = require("child_process");

export function doAction(command: string): boolean {
  let success : boolean = true;
  exec(command, (err, stdout, stderr) => {
    if (stdout){ 
      
      console.log(stdout);
      console.log('standard output');
      console.log('standard output');
      console.log('standard output');
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
