terraform {
  backend "s3" {
    bucket = "young-minds-app-project-1-terraform-state"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "my-dynamodb-table"
  }
}
