const { find } = require('lodash')
const beautifyUnique = require('mongoose-beautiful-unique-validation')
const restful = require('node-restful')
const mongoose = restful.mongoose

const companyRegistrationSchema = new mongoose.Schema({
   corporateName: { type: String, required: true },
   registerCompany: { type: String, required: false },
   responsibleContact: { type: String, required: false },
   mail: { type: String, required: false },
   telephone: { type: String, required: true },
   serviceDescription: { type: String, required: true },
   matriz: { type: String, required: true },
   address: [{
      zipCode: {type: String, required: true},
      street: {type: String, required: true}, 
      number: {type: String, required: true},
      complement: {type: String, required: false},
      city: {type: String, required: true}, 
      state: {type: String, required: true},
      country: {type: String, required: true}
    }],
    status: { type: Boolean, required: true }
})

companyRegistrationSchema.plugin(beautifyUnique)

module.exports = restful.model('CompanyRegistration', companyRegistrationSchema )