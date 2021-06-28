import * as AWS from 'aws-sdk'
import { v4 as uuidv4 } from 'uuid'
import ServerInternalError from '../../custom-errors/server-internal-error'

const dynamodb = new AWS.DynamoDB.DocumentClient()

interface ICreate {
  name: String;
  description: String;
  price: String;
}

const createProduct = async ({
  name,
  description,
  price
}: ICreate) => {
  const id = uuidv4()
  const now = new Date().toISOString()

  const product = {
    id,
    name,
    description,
    price,
    created_at: now,
    updated_at: now
  }

  try{
    await dynamodb.transactWrite({
      TransactItems: [
        {
          Put: {
            TableName: process.env.DYNAMO_TABLE_PRODUCTS as string,
            Item: product
          },
        },
        {
          Put: {
            TableName: process.env.DYNAMO_TABLE_PRODUCTS_EVENTS as string,
            Item: {
              id,
              action: 'product.created',
              data_event: {
                ...product
              }
            }
          },
        }
      ]
    }).promise()

    return product;
  }catch(error) {
    console.log(error)
    throw new ServerInternalError()
  }
}

export default createProduct;
