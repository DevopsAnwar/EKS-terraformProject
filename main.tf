resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.my_api_task_execution_role.arn
  task_role_arn = aws_iam_role.my_api_task_execution_role.arn

#  container_definitions = jsonencode([{
#    name  = "my-container"
#    image = "anastasiyaohal/clockbox:latest" 
#    essential = true
#      portMappings = [
#        {
#          containerPort = 80
#          hostPort      = 80
#        }
#      ]
#  }])

 container_definitions = <<EOF
  [
    {
      "name": "sun-api",
      "image": "anastasiyaohal/clockbox:latest",
      "portMappings": [
        {
          "containerPort": 3000
        }
      ]
    }
  ]
  EOF
}

resource "aws_ecs_service" "my_service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = ["subnet-0287356ba65c47876"] 
  }
}


resource "aws_iam_role" "my_api_task_execution_role" {
  name               = "my-api-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Normally we'd prefer not to hardcode an ARN in our Terraform, but since this is
# an AWS-managed policy, it's okay.
data "aws_iam_policy" "ecs_task_execution_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Attach the above policy to the execution role.
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.my_api_task_execution_role.name
  policy_arn = data.aws_iam_policy.ecs_task_execution_role.arn
}
