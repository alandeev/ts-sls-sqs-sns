import { APIGatewayProxyEvent } from "aws-lambda";
import removeProduct from '../../../repositories/products/remove';
import validate from "./validate";

const main = async (event: APIGatewayProxyEvent) => {
  const product_id = validate(event.pathParameters?.id as string)

  await removeProduct(product_id)
}

export default main;
