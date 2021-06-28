const AWS = require('aws-sdk')

const sns = new AWS.SNS()

const main = async (event) => {
  for(const record of event.Records) {
    if(record.eventName !== "INSERT") {
      console.warn({
        status: "EVENT_NOT_IS_INSERT",
        message: "Stoped because eventName not is INSERT"
      })
      return;
    }

    const tableName = 'products-events'

    const params = {
      Message: JSON.stringify(record),
      TopicArn: `arn:aws:sns:us-east-1:050587934116:${tableName}`
    };


    await sns.publish(params).promise()
  }
}

export default main;
