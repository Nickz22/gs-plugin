const { exec } = require("child_process");
const messages = {
  authError: "Please run sfdx force:config:set defaultusername=your_alias",
  dirError:
    'HINT: Please cd into the "src" dir of the git repo before using plugin',
};

export function doAction(command: string) {
  exec(command, (err, stdout, stderr) => {
    if (stderr) {
      if (stderr.includes("OAuth")) {
        log(messages.authError);
      } else if (stderr.includes("No such file")) {
        log(stderr);
        log(messages.dirError);
      } else {
        log(stderr);
      }
    }
    if (stdout) {
      log(stdout);
    }
  });
}

export async function doActionWithCallback(command: string, callback: any) {
  console.log("running");
  let success: boolean = true;
  await exec(command, (err, stdout, stderr) => {
    if (err) {
      success = false;
      log(err);
      log("ERROR");
      return success;
    }
    if (stdout) {
      if (stdout != null && stdout.length > 0) {
        log(stdout);
        callback();
      } else {
        log("empty std out...");
      }
    }
  });
  return success;
}

export function log(output: any) {
  console.log(output);
}
