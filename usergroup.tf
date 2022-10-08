
#This module creates a set of users and group
#A no permission policy
#user 1 inherites the policy.
#Group is attached to the policy as well.

#NOTE: For this module, Variables are not set, This is NoT a best practice.


#user 1
resource "aws_iam_user" "userone" {
  name = "userone"
}
#user 2
resource "aws_iam_user" "usertwo" {
  name = "usertwo"
}
#Group is created
#A development group is created.
resource "aws_iam_group" "dev_group" {
  name = "dev_group"
}

#Group Membership
#user 1 and user 2 are added to development group named dev group
resource "aws_iam_group_membership" "devteam" {
  name = "devteam"
  users = [
     "aws_iam_user.userone.userone",
     "aws_iam_user.usertwo.usertwo"
  ] 
  group = aws_iam_group.dev_group.name
}

#Policy attachment
#This policy attached the above group and user 1
resource "aws_iam_policy_attachment" "attachment" {
  name = "attachment"
  groups = [ "aws_iam_group.dev_group.name" ]
  users = [ "aws_iam_user.userone.userone" ]
  policy_arn = "arn:aws:iam::aws:policy/AWSDenyAll"
}

# Assume Role Policy
#A no permission role is created
#Anyone or group can be attached to this policy
resource "aws_iam_policy" "no-permission-role" {
  name        = "no-permission-role"
  description = "energi development environment policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "NotAction"
      ],
      "Effect": "Deny",
      "Resource": "*"
    }
  ]
}
EOF
}
#here we attache users, roles, and group to the policy.
#user 1 and Dev group are attached to the no permission policy.
resource "aws_iam_policy_attachment" "dev-pol-attach" {
  name       = "dev-policy-attachment"
  users      = ["aws_iam_user.user_one.userone"]
  roles      = ["aws_iam_role.no-permission-role"]
  groups     = ["aws_iam_group.dev_group"]
  policy_arn = aws_iam_policy.no-permission-role.arn
}


