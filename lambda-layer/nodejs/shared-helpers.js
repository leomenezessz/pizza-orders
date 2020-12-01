const Joi = require('joi');


const validateIncomingOrder = async (orderPayload) => {
    return await Joi.object({
            name: Joi.string().required(),
            value: Joi.number().integer().required()
        }
    ).validateAsync(orderPayload)
}


const apiGatewayResponse = (statusCode, body, isBase64= false) => {
    return {
        "statusCode": statusCode,
        "body": JSON.stringify(body),
        "isBase64Encoded": isBase64
    };
}


module.exports = {
    apiGatewayResponse,
    validateIncomingOrder
}