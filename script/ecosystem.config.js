module.exports= {
    apps: [
        {
            name: 'daemon',
            script: `${process.env.MCSM_PATH}/daemon/app.js`,
            instance: 1,
            args: '--max-old-space-size=8192'
        },
        {
            name: 'web',
            script: `${process.env.MCSM_PATH}/web/app.js`,
            instance: 1,
            args: '--max-old-space-size=8192'
        }
    ]
}