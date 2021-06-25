import * as Joi from 'joi'
import ValidationError from '../../../custom-errors/validation-error'

const schema = Joi.string().uuid().required()

const validate = (product_id: string) => {
  const { error, value } = schema.validate(product_id, {
    abortEarly: false
  })

  if(error) {
    throw new ValidationError(error.message, error.details)
  }

  return value;
}

export default validate;
