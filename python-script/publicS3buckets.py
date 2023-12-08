import boto3

def check_public_access():
    s3 = boto3.client('s3')
    response = s3.list_buckets()

    buckets_with_public_access = []

    for bucket in response['Buckets']:
        bucket_name = bucket['Name']
        try:
            bucket_policy = s3.get_bucket_policy_status(Bucket=bucket_name)
            if bucket_policy['PolicyStatus']['IsPublic']:
                buckets_with_public_access.append(bucket_name)
        except s3.exceptions.ClientError as e:
            if e.response['Error']['Code'] == 'NoSuchBucketPolicy':
                print(f"No bucket policy found for '{bucket_name}'")
            else:
                print(f"Error accessing bucket policy for '{bucket_name}': {e}")

    return buckets_with_public_access

if __name__ == "__main__":
    public_buckets = check_public_access()
    if public_buckets:
        print("Buckets with public access:")
        for bucket_name in public_buckets:
            print(bucket_name)
    else:
        print("No buckets found with public access")
