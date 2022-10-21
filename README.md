# EstEID on AWS API Gateway

This project is for testing if you can use mTLS functionality of the AWS API Gateway with Estonian
ID cards.

The answer is you can not.

![AWS API Warning](images/warning.png?raw=true "AWS API Warning")

## Alternatives

- Use a [NLB](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/introduction.html) to
  pass through the TLS connection to your host and handle it there.