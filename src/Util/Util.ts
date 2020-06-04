const { exec } = require("child_process");

export function doAction(command: string) {
  /**
   * need to remove this from util since its only relevant to beta packaging
   */
  let mockPoller = setInterval(() => {  
    console.log('spinning up new beta package...');
  }, 15000);
  exec(command, (err, stdout, stderr) => {
    if (stdout) console.log(stdout);
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
    clearInterval(mockPoller);
  });
}
