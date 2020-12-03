const {DynamoDB: db, SNS} = require("aws-sdk");
const {v4: uuid} = require('uuid');
const helper = require('/opt/nodejs/shared-helpers')
const client = new db.DocumentClient();
const tableName = "Orders"
const sns = new SNS()


exports.handler = async (event) => {
    try {

        const order = JSON.parse(event.body)
        const {error} = await helper.validateIncomingOrder(order)

        if (!error) {

            order.id = uuid().toString()
            order.status = "Esperando a pizzaria..."

            const data = await client.put({TableName: tableName, Item: order}).promise()

            if (data) {

                const message = JSON.stringify(order)

                const params = {
                    Message: JSON.stringify({ "default" :  message}),
                    MessageStructure: 'json',
                    TopicArn: 'arn:aws:sns:us-east-1:727646912140:orders'
                };

                await sns.publish(params).promise()

                const orderMessage = {"id" : order.id, "message": "Pedido Recebido.", "description" : "Já recebemos seu pedido, que logo logo será confirmado pela pizzaria."}

               return  helper.apiGatewayResponse(200, orderMessage)

            }
        }

    } catch (err) {
        return helper.apiGatewayResponse(400, {"message": err.message})
    }
}