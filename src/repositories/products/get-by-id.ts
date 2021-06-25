import * as AWS from 'aws-sdk'
const dynamodb = new AWS.DynamoDB.DocumentClient()

const getProduct = async (product_id: string) => {
  const result = await dynamodb.get({
    TableName: process.env.DYNAMO_TABLE_PRODUCTS as string,
    Key: {
      id: product_id
    }
  }).promise()

  return result.Item;
}

export default getProduct;
