const {DynamoDB: db} = require("aws-sdk");
const {v4: uuid} = require('uuid');
const helper = require('/opt/nodejs/shared-helpers')
const client = new db.DocumentClient();
const tableName = "Orders"


exports.handler = async (event) => {
    try {
        const jsonBody = JSON.parse(event.body)
        const {error} = await helper.validateIncomingOrder(jsonBody)

        if (!error) {

            jsonBody.id = uuid()
            jsonBody.status = "Received"

            const data = await client.put({TableName: tableName, Item: jsonBody}).promise()

            if (data) return helper.apiGatewayResponse(200, {"message": "Order created!", "data" : data})
        }

    } catch (err) {
        return helper.apiGatewayResponse(400, {"message": err.message})
    }
}