const { spawn } = require('child_process');

function start (sh) {
    return new Promise((resolve, reject) => {
        const terminal = spawn('bash', [
            '-c',
            `cd ${process.env.MCSM_PATH} && bash ${sh}.sh`
        ]);
    
        terminal.stdout.on('data', (data) => {
            console.log(`stdout: ${data}`);
            resolve();
        });
    
        terminal.stderr.on('data', (data) => {
            console.error(`stderr: ${data}`);
            reject();
        });
    })
}

(async () => {
    await start('start-daemon');
    await start('start-web');
})()