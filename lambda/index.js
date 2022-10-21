exports.handler = function (event, context, callback) {
  console.log('Method ARN: ' + event.methodArn);
  console.log(context.authentication.clientCert);
  const authResponse = {
    "principalId": "user",
    "policyDocument": {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "execute-api:Invoke",
          "Effect": "Allow",
          "Resource": "arn:aws:execute-api:eu-central-1:633923511767:ngzcqxhmhh/*/GET/id"
        }
      ]
    },
    "context": {
      "stringKey": "value",
      "numberKey": "1",
      "booleanKey": "true"
    },
  };
  callback(null, authResponse);
}