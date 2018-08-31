Command to create S3 buckets and policy. 

    aws s3api create-bucket --bucket bucket-name --region us-east-1
    aws s3api put-bucket-policy --bucket bucket-name --policy file://policy.json


    policy.json


    {
    "Version": "2012-10-17",
    "Id": "PutObjPolicy",
    "Statement": [
    {
    "Sid": "DenyIncorrectEncryptionHeader",
    "Effect": "Deny",
    "Principal": "*",
    "Action": "s3:PutObject",
    "Resource": "arn:aws:s3::: bucket-name/*",
    "Condition": {
    "StringNotEquals": {
    "s3:x-amz-server-side-encryption": "AES256"
    }
    }
    },
    {
    "Sid": "DenyUnEncryptedObjectUploads",
    "Effect": "Deny",
    "Principal": "*",
    "Action": "s3:PutObject",
    "Resource": "arn:aws:s3::: bucket-name/*",
    "Condition": {
    "Null": {
    "s3:x-amz-server-side-encryption": "true"
    }
    }
    },
    {
    "Sid": "Access-to-specific-VPCE-only",
    "Effect": "Deny",
    "Principal": "*",
    "Action": [
    "s3:GetObject*",
    "s3:PutObject*",
    "s3:DeleteObject*"
    ],
    "Resource": [
    "arn:aws:s3::: bucket-name",
    "arn:aws:s3::: bucket-name/*"
    ],
    "Condition": {
    "StringNotEquals": {
    "aws:sourceVpce": [
    "vpce-15c7087c",
    "vpce-f0834f99",
    "vpce-8d72bae4"
    ]
    }
    }
    }
    ]
    }
