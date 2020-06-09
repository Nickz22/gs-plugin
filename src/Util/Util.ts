const { exec } = require("child_process");
const genericError : string = 'oops, looks like an error occurred while';
const messages = {
  authError : "Please run sfdx force:config:set defaultusername=your_alias",
  dirError : 'HINT: Please cd into the "src" dir of the git repo before using plugin'
}

export function doAction(command: string){
  exec(command, (err, stdout, stderr) => {
    if (stderr) {
      if (stderr.includes("OAuth")) {
        log(messages.authError);
      }else if(stderr.includes('No such file')){
        log(stderr);
        log(messages.dirError);
      }else{
        log(stderr);
      } 
    }
    if(stdout){
      log(stdout);
    }
  });
}

export function log(output: any){
  console.log(output);
}
