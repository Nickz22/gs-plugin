const { exec } = require("child_process");

export function doAction(command: string) {
  /**
   * need to remove this from util since its only relevant to beta packaging
   */
  let mockPoller = setInterval(() => {  
    // console.log('spinning up new beta package...');
  }, 3000);
  console.log('utils');
  exec(command, (err, stdout, stderr) => {
    if (stdout) console.log("RESPONSE \n " + stdout);
    if (stderr) {
      if (stderr.includes("OAuth")) {
        console.log(
          "Please run sfdx force:config:set defaultusername=your_alias"
        );
      }else if(stderr.includes('No such file')){
        console.log('ERROR: '+stderr);
        console.log('HINT: Please cd into the "src" dir of the git repo before using plugin');
      }else console.log("ERROR: \n" + stderr);
    }
    clearInterval(mockPoller);
  });
}
