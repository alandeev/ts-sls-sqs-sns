import { APIGatewayProxyEvent } from "aws-lambda";
import NotFoundError from "../../../custom-errors/not-found-error";
import getProductById from '../../../repositories/products/get-by-id';
import validate from "./validate";

const main = async (event: APIGatewayProxyEvent) => {
  const product_id = validate(event.pathParameters?.id as string)

  const product = await getProductById(product_id)
  if(!product) {
    throw new NotFoundError('Product not found')
  }

  return product;
}

export default main;
