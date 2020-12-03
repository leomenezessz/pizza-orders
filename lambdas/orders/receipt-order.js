const {DynamoDB: db} = require("aws-sdk");
const helper = require('/opt/nodejs/shared-helpers')
const client = new db.DocumentClient()
const tableName = "Receipts"
const {v4: uuid} = require('uuid');


exports.handler = async (event) => {
    try {
        const order = JSON.parse(event.Records[0].Sns.Message)
        const {error} = await helper.validateIncomingOrderToReceipt(order)

        const receipt = {
            "id" : uuid().toString(),
            "clientName" : order.clientName,
            "date" : new Date().toLocaleString(),
            "value" : order.value,
            "orderId" : order.id,
            "pizza" : order.pizza
        }

        if (!error){
            await client.put({TableName: tableName, Item: receipt}).promise()
        }

    }catch (e) {
        console.error(e)
    }
}