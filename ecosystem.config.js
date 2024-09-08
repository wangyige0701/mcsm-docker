/** @type {import('pm2').StartOptions[]} */
module.exports = [{
    cwd: `${process.env.MCSM_PATH}/daemon`,
    script: 'app.js',
    name: 'daemon',
    max_memory_restart: '8G',
    args: '--max-old-space-size=8192'
}, {
    cwd: `${process.env.MCSM_PATH}/web`,
    script: 'app.js',
    name: 'web',
    instances: 1,
    max_memory_restart: '4G',
    args: '--max-old-space-size=4096'
}];