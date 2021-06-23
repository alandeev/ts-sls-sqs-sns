import * as Joi from 'joi'
import ValidationError from '../../../custom-errors/validation-error'

const schema = Joi.object({
  name: Joi.string().required(),
  description: Joi.string().required(),
  price: Joi.number().required()
}).required()

const validate = (body) => {
  const { value, error } = schema.validate(body, {
    abortEarly: false
  })

  if(error) {
    throw new ValidationError(error.message, error.details)
  }

  return value;
}

export default validate;
