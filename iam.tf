resource "aws_iam_policy" "workers_persistent_volume_policy" {
  name        = "EKSWorkerPersistentVolume"
  path        = "/"
  description = "Provides access to the worker nodes for creation of persistent volumes"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    	{
          Action = [
		"ec2:AttachVolume",
        	"ec2:CreateSnapshot",
        	"ec2:CreateTags",
        	"ec2:CreateVolume",
	        "ec2:DeleteSnapshot",
	        "ec2:DeleteTags",
	        "ec2:DeleteVolume",
	        "ec2:DescribeAvailabilityZones",
	        "ec2:DescribeInstances",
	        "ec2:DescribeSnapshots",
	        "ec2:DescribeTags",
	        "ec2:DescribeVolumes",
	        "ec2:DescribeVolumesModifications",
	        "ec2:DetachVolume",
	        "ec2:ModifyVolume"
          ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "workers_WorkerNodePersistentVolumePolicy_Attachment" {
      role       = module.eks.worker_iam_role_name
      policy_arn = aws_iam_policy.workers_persistent_volume_policy.arn
}
