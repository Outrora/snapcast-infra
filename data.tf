

data "aws_subnets" "subnets"{
    filter {
        name = "vpc-id"
        values = [local.vpc_id]
    }
}


data "aws_iam_role" "labrole" {
  name = "LabRole"
}

output "labrole_arn" {
  value = data.aws_iam_role.labrole.arn
}