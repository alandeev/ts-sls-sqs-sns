import { APIGatewayProxyEvent } from 'aws-lambda';
import create from '../../../repositories/products/create';
import validate from './validate'

const main = async (event: APIGatewayProxyEvent) => {
  const data = validate(event.body)

  const product = await create(data);

  return product;
}

export default main;
