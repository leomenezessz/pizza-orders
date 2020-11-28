const {DynamoDB: db} = require("aws-sdk");
const {v4: uuid} = require('uuid');
const response = require('shared-helpers')

const client = new db.DocumentClient();
const tableName = "Orders"


exports.handler = async (event, context) => {

    const order = JSON.parse(event.body);
    order.id = uuid()
    order.status = "Received"

    return client.put({TableName: tableName, Item: order}).promise().then((data) => {
        return new response(200, {"message": "Order created!"}).create()
    }).catch((error) => {
        return new response(400, {"message": error.message}).create()
    });
}