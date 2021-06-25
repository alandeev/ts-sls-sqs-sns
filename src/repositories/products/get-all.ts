import * as AWS from 'aws-sdk'
const dynamodb = new AWS.DynamoDB.DocumentClient()

const getProducts = async () => {
  const result = await dynamodb.scan({
    TableName: process.env.DYNAMO_TABLE_PRODUCTS as string,
  }).promise();

  return result.Items;
}

export default getProducts;
