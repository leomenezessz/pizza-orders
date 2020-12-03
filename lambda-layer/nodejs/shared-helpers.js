const Joi = require('joi');

const validateIncomingOrder = async (orderPayload) => {
    return await Joi.object({
            clientName: Joi.string().required(),
            clientAddress: Joi.string().required(),
            pizza: Joi.string().required(),
            value: Joi.number().integer().required(),
            orderDate: Joi.string().required()
        }
    ).validateAsync(orderPayload)
}

const validateIncomingOrderToReceipt = async (orderPayload) => {
    return await Joi.object({
            id: Joi.string().required(),
            clientName: Joi.string().required(),
            clientAddress: Joi.string().required(),
            pizza: Joi.string().required(),
            value: Joi.number().integer().required(),
            orderDate: Joi.string().required(),
            status: Joi.string().required()
        }
    ).validateAsync(orderPayload)
}

const validateIncomingOrderToConfirm = async (orderPayload) => {
    return await Joi.object({
            id: Joi.string().required(),
        }
    ).validateAsync(orderPayload)
}

const apiGatewayResponse = (statusCode, body, isBase64 = false) => {
    return {
        "statusCode": statusCode,
        "body": JSON.stringify(body),
        "isBase64Encoded": isBase64
    };
}

module.exports = {
    apiGatewayResponse,
    validateIncomingOrder,
    validateIncomingOrderToReceipt,
    validateIncomingOrderToConfirm
}