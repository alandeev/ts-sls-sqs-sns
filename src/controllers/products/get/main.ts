import { APIGatewayProxyEvent } from "aws-lambda";
import getProducts from "../../../repositories/products/get-all";

const main = async (event: APIGatewayProxyEvent) => {

  const products = await getProducts()

  return products;
}

export default main;
