const express = require('express')

module.exports = function (server) {
    const protectedApi = express.Router();
    server.use('/api', protectedApi);

    server.use('/status', (req, res) =>
        res.send(`BACKEND is runner.`)
    );

    const recommendation = require('../api/companyRegistration/companyRegistrationService');
    recommendation.register(protectedApi, '/companyRegistration');

    const register = require('../api/registerLoginAccess/registrationLoginAccessService');
    register.register(protectedApi, '/registerLoginAccess');

    server.use(express.static(require('path').join(__dirname, '../public')));
}