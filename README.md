# TerraformK8Webpage
This is a repo that contains the terraform code that will create a K8 cluster that will host a simple web page


README for web server using EKS and terraform

Pre reqs: Have your amazon cli configured, kubectl and terraform downloaded

First you need to have 3 files created:
providers.tf:  this file says what providers we have and their version and the aws region we are deploying to
vpc.tf: this file sets up the Virtual Private Network (VPC) for the projcet. It sets up the private and public subnets, azs, cidir, and other networking componets
eks.tf: this file sets up the EKS cluster. It connects the vpc and its subnets, creates worker nodes, enables permissions to the cluster, etc

You need to run the commands in the following order:

terraform init (this command initializes the env)
terraform plan (this command reviews the plan that will deploy)
terraform apply (this command applies the configuration to your aws account and creates the resources)

Once everything is provisioned you need to connect kubectl to your aws EKS cluster, run the command

aws eks update-kubeconfig --region region-code --name my-cluster (replace region-code with the region it was deployed to and my-cluster with the clusters name)

If you can run this command then you are connected,

kubectl get nodes

You now need to apply the yaml file, you can do this by using this command

kubectl apply -f web-deployment.yaml

Then verify the pods are running using 

kubectl get pods

Now to get the cluster to talk outside of the VPC private subnet we need to create a bridge using a LoadBalancer, you can do this by applying this yaml

kubectl apply -f web-service.yaml

Give it a couple of mins then run 

kubectl get service web-public-access

Look for the EXTERNAL-IP column. You'll see a long domain name ending in .amazonaws.com. Paste that into the web browser and you should see a page that says "Welcome to nginx!"

If this worked, you can continue to explore what was made using kubectl or going through the AWS Consle

AT THE END YOU MUST DESTROY EVERYTHING SO YOU ARE NOT CHARGED A RIDICULOUS RATE 

Type the commmand

terraform destroy
