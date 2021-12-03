# Terraform AWS Codepipeline Sample

<p>There are many approaches and tools to build a decent CI/CD.
I've been creating Cloudformation stacks to provision serverless infrastructure and then setup AWS Codepipeline to do the continues delivery.</p>

This was the flow I had to follow to create a pipeline for a lambda function:

1. Creating an ECR repository and push the lambda docker image to the repository
2. Creating a Cloudformation stack
3. Creating an AWS Codebuild that builds the new docker image based on the source artifact and pushes it the ECR and then update the lambda inside `Buildspec.yml`
4. Creating an Stage for cloudformation, so if we needed to change lambda's resource, cron expression or anything else do it in `template.yml` and simply push the code on git
5. Adding various policies to Codebuild IAM Role based on the conditions

<p>So, I created a Terraform that automates all these for me :) </p>

# Disclaimer

<p> I know using cloudformation is stupid idea in this case.
Probably using Terraform to provision the infrastructure at the first place, removing Cloudformation stack from pipeline and create a separated Terraform module for AWS Codepipline would be more of a legit step to take
but that would be a job for another day. </p>
This codebase will stay here as an example to Pipelines with Terraform and Cloudformation.

# Usage 

Simply fill the variables inside the `tfvar` file and then run common Terraform commands you need.




