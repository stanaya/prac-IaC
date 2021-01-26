#import boto3
from urllib import parse

#s3 = boto3.client('s3')

def handler(event, context):
    # Slashコマンドから送られてきた引数の文字列を取得
    #text = parse.parse_qs(event['body'])['text'][0]

    response = {
        "statusCode": 200,
        "body": "test_OK\n"
    }
    return response
