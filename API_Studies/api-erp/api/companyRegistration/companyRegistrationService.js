const _ = require('lodash')
const CompanyRegistration = require('./companyRegistration')
const fullNameRegex = /^[A-ZÀ-Ÿ][A-zÀ-ÿ']+\s([A-zÀ-ÿ']\s?)*[A-ZÀ-Ÿ][A-zÀ-ÿ']+$/ 
const mailRegex = /\S+@\S+\.\S+/;

// Gerenciamento da API REST
CompanyRegistration.methods(['get', 'post', 'put', 'delete'])
CompanyRegistration.updateOptions({ new: true, runValidators: true })

// Tratativa das mensagens de erro. Retorna apenas o campo com erro - Insert
CompanyRegistration.after('post', sendErrorsOrNext).after('put', sendErrorsOrNext)
CompanyRegistration.before('post', companyRegistration).before('put', companyRegistration)

function sendErrorsOrNext(req, res, next) {
  const bundle = res.locals.bundle
  
  if (bundle.errors) {
    var errors = parseErrors(bundle.errors)
    res.status(500).json({ errors })
  } else {
     next()    
  }
}

// Gerencia as mensagens de erros geradas no front-end
function parseErrors(nodeRestfulErrors) {
  const errors = []
  _.forIn(nodeRestfulErrors, error => errors.push(error.message))
  return errors
}

// Serviço para contar a quantidade de registros gerados para a paginação do front-end.
CompanyRegistration.route('count', function (req, res, next) {
  CompanyRegistration.count(function (error, value) {
    if (error) {
      res.status(500).json({ errors: [error] })
    } else {
      res.json({ value })
    }
  })
})

const sendErrorsFromDB = (res, dbErrors) => {
  const errors = []
  _.forIn(dbErrors.errors, error => errors.push(error.message))
  return res.status(400).json({ errors })
}

function companyRegistration(req, res, next){ 
  const corporateName = req.body.corporateName || ''
  const registerCompany = req.body.registerCompany || ''
  const responsibleContact = req.body.responsibleContact || ''
  const mail = req.body.mail || ''
  const telephone = req.body.telephone || ''
  const serviceDescription = req.body.serviceDescription || ''
  const matriz = req.body.matriz || ''
  const zipCode = req.body.address.zipCode || ''
  const street = req.body.address.street || ''
  const number = req.body.address.number || ''
  const complement = req.body.address.complement || ''
  const city = req.body.address.city || ''
  const state = req.body.address.state || ''
  const country = req.body.address.country || ''

  if (corporateName == null || corporateName == "") {
    return res.status(400).send({ alert: ["O campos Nome da Empresa é obrigatório."] })
  }

  /* if (!corporateName.match(fullNameRegex)) {
    return res.status(400).send({ alert: ['Informe o nome e sobrenome.'] })
  } */

  if (registerCompany == null || registerCompany == "") {
    return res.status(400).send({ alert: ["O campo Registro da Empresa é Obrigatório."] })
  }

  if (registerCompany.length > 500) {
    return res.status(400).send({ alert: ["O campo permite apenas 500 caracteres."] })
  }

  if (responsibleContact == null || responsibleContact == "") {
    return res.status(400).send({ alert: ["Informe o Contato Responsável."] })
  }

  if(!mail.match(mailRegex)){
    return res.status(400).send({ alert: ["O e-mail informado é inválido. Informe um e-mail no formato [nome@dominio.com ou nome@dominio.com.br]."]})
  }

  if (telephone == null || telephone == "") {
    return res.status(400).send({ alert: ["O campo Telefone é obrigatório."] })
  }

  if (serviceDescription == null || serviceDescription == "") {
    return res.status(400).send({ alert: ["O campo Descrição do Serviço é obrigatório."] })
  }

  if (serviceDescription.length > 500) {
    return res.status(400).send({ alert: ["O campo permite apenas 500 caracteres."] })
  }

  if (matriz == null || matriz == "") {
    return res.status(400).send({ alert: ["O campo Matriz é obrigatório."] })
  }

  if (zipCode == null || zipCode == "") {
    return res.status(400).send({ alert: ["O campo CEP é obrigatório."] })
  }

  if (street == null || street == "") {
    return res.status(400).send({ alert: ["O campo Rua é obrigatório."] })
  }

  if (number == null || number == "") {
    return res.status(400).send({ alert: ["O campo Número é obrigatório."] })
  }

  if (city == null || city == "") {
    return res.status(400).send({ alert: ["O campo Cidade é obrigatório."] })
  }

  if (state == null || state == "") {
    return res.status(400).send({ alert: ["O campo UF é obrigatório."] })
  }

  if (state.length > 2) {
    return res.status(400).send({ alert: ["O campo permite apenas 2 caracteres."] })
  }

  if (country == null || country == "") {
    return res.status(400).send({ alert: ["O campo País é obrigatório."] })
  }

  const newBody = new CompanyRegistration(
    {
      corporateName: corporateName,
      registerCompany,
      responsibleContact,
      mail,
      telephone,
      serviceDescription,
      matriz,
      address: [{
        zipCode,
        street,
        number,
        complement,
        city,
        state,
        country
      }],
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

module.exports = CompanyRegistration