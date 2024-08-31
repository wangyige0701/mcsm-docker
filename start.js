const { spawn } = require('child_process');

function create (dir) {
    const terminal = spawn('gnome-terminal', [
        '--working-directory=' + process.env.MCSM_PATH,
        '--',
        'bash',
        '-c',
        `cd ${dir} && pm2-runtime start app.js`
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