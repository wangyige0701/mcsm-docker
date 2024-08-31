const { spawn } = require('child_process');

function start (sh) {
    const terminal = spawn('bash', [
        '-c',
        `cd ${process.env.MCSM_PATH} && bash ${sh}.sh`
    ]);

    terminal.stdout.on('data', (data) => {
        console.log(`stdout: ${data}`);
    });

    terminal.stderr.on('data', (data) => {
        console.error(`stderr: ${data}`);
    });
}

start('start-daemon');
start('start-web');