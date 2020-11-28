
class LambdaResponse{
    constructor(statusCode, body, isBase64) {
        this.statusCode = statusCode
        this.body = body
        this.isBase64 = isBase64
    }

    create(){
        return{
            "statusCode": this.statusCode,
            "body": JSON.stringify(this.body),
            "isBase64Encoded": this.isBase64
        };
    }
}

module.exports = LambdaResponse