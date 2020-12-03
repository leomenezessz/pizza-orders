const {DynamoDB: db} = require("aws-sdk");
const helper = require('/opt/nodejs/shared-helpers')
const client = new db.DocumentClient();
const tableName = "Orders"


exports.handler = async (event) => {
    try {

        const order = JSON.parse(event.body)

        const {error} = await helper.validateIncomingOrderToConfirm(order)


        if (!error) {

            const params = {
                TableName: tableName,
                Key:{
                    "id": order.id
                },
                UpdateExpression: "set #st=:s, confirmationDate=:p",
                ExpressionAttributeValues:{
                    ":s":"Pizza em preparo.",
                    ":p" : new Date().toLocaleString()
                },
                ExpressionAttributeNames :{
                    "#st": "status",
                },
                ReturnValues:"UPDATED_NEW"
            };

            const data = await client.update(params).promise()

            if (data) return helper.apiGatewayResponse(200, data.Attributes)
        }

    } catch (err) {
        console.log(err)
        return helper.apiGatewayResponse(400, {"message": err.message})
    }
}