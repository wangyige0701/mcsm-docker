const { spawn } = require('child_process');

function create (dir) {
    const target = `${process.env.MCSM_PATH}/${dir}`;

    const terminal = spawn('bash', [
        '-c',
        `cd ${target} && pm2-runtime start app.js`
    ]);

    terminal.stdout.on('data', (data) => {
        console.log(`stdout: ${data}`);
    });

    terminal.stderr.on('data', (data) => {
        console.error(`stderr: ${data}`);
    });
}

create('daemon');
create('web');