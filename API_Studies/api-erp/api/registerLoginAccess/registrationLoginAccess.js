const { find } = require('lodash')
const beautifyUnique = require('mongoose-beautiful-unique-validation')
const restful = require('node-restful')
const mongoose = restful.mongoose

const registrationLoginAccessSchema = new mongoose.Schema({
   fullName: { type: String, required: true },
   mail: { type: String, required: true },
   department: { type: String, required: true },
   costCenterName: { type: String, required: true },
   roleName: { type: String, required: true },
   registerCompany: { type: String, required: true },
   accessProfile: { type: String, required: true },
   status: { type: Boolean, required: true }
})

///teste
registrationLoginAccessSchema.plugin(beautifyUnique)

module.exports = restful.model('RegistrationLoginAccess', registrationLoginAccessSchema )

/* 
registrationLoginAccess
companyRegistration
job registration
department registration
access profile registration
cost center registration
access login 
*/