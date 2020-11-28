const {DynamoDB: db} = require("aws-sdk");
const {v4: uuid} = require('uuid');

const client = new db.DocumentClient();
const tableName = "Orders"


exports.handler = async function (event, context) {
    const responseBody = {
        "message": "Mete o loko.",
    }

    return {
        "statusCode": 200,
        "body": JSON.stringify(responseBody),
        "isBase64Encoded": false
    };
}