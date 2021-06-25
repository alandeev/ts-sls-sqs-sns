import * as AWS from 'aws-sdk'
const dynamodb = new AWS.DynamoDB.DocumentClient()

const removeProduct = async (product_id: string) => {
  await dynamodb.delete({
    TableName: process.env.DYNAMO_TABLE_PRODUCTS as string,
    Key: {
      id: product_id
    }
  }).promise()
}

export default removeProduct;
