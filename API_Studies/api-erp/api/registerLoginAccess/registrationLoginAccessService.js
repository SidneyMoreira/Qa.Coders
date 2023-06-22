const _ = require('lodash')
const RegistrationLoginAccess = require('./registrationLoginAccess')
const fullNameRegex = /^[A-ZÀ-Ÿ][A-zÀ-ÿ']+\s([A-zÀ-ÿ']\s?)*[A-ZÀ-Ÿ][A-zÀ-ÿ']+$/ 
const mailRegex = /\S+@\S+\.\S+/;

RegistrationLoginAccess.methods(['get', 'post', 'put', 'delete'])
RegistrationLoginAccess.updateOptions({ new: true, runValidators: true })

RegistrationLoginAccess.after('post', sendErrorsOrNext).after('put', sendErrorsOrNext)
RegistrationLoginAccess.before('post', register).before('put', register)

function sendErrorsOrNext(req, res, next) {
  const bundle = res.locals.bundle
  
  if (bundle.errors) {
    var errors = parseErrors(bundle.errors)
    res.status(500).json({ errors })
  } else {
     next()    
  }
}

function parseErrors(nodeRestfulErrors) {
  const errors = []
  _.forIn(nodeRestfulErrors, error => errors.push(error.message))
  return errors
}

const sendErrorsFromDB = (res, dbErrors) => {
  const errors = []
  _.forIn(dbErrors.errors, error => errors.push(error.message))
  return res.status(400).json({ errors })
}

function register(req, res, next) {
  const fullName = req.body.fullName || ''
  const mail = req.body.mail || ''
  const department = req.body.department || ''
  const costCenterName = req.body.costCenterName || ''
  const roleName = req.body.roleName || ''
  const registerCompany = req.body.registerCompany || ''
  const accessProfile = req.body.accessProfile || ''

  if(!fullName.match(fullNameRegex)){
    return res.status(400).send({ alert: ["Informe o Nome e Sobrenome."]})
  }

  if(mail == null || mail == ""){
    return res.status(400).send({ alert: ["O campo E-mail é obrigatório."]})
  }
  
  if(!mail.match(mailRegex)){
    return res.status(400).send({ alert: ["O e-mail informado é inválido. Informe um e-mail no formato [nome@dominio.com ou nome@dominio.com.br]."]})
  }

  if(department == null || department == ""){
    return res.status(400).send({ alert: ["O campo Departamento é obrigatório."]})
  }

  if(costCenterName == null || costCenterName == ""){
    return res.status(400).send({ alert: ["O campo Centro de Custo é obrigatório."]})
  }

  if(roleName == null || roleName == ""){
    return res.status(400).send({ alert: ["O campo Cargo é obrigatório."]})
  }

  if(registerCompany == null || registerCompany == ""){
    return res.status(400).send({ alert: ["O campo Nome da Empresa é obrigatório."]})
  }

  if(accessProfile == null || accessProfile == ""){
    return res.status(400).send({ alert: ["O campo Perfil de Acesso é obrigatório."]})
  }


  const newBody = new RegistrationLoginAccess({
      fullName,
      mail,
      department,
      costCenterName,
      roleName,
      registerCompany,
      accessProfile,
      status:  true 
  })

  newBody.save(err => {
      if (err) {
          return sendErrorsFromDB(res, err)
      } else {
          res.status(201).json(newBody)
      }
  })
}

module.exports = RegistrationLoginAccess