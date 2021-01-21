def aws_secrets = [
  [path: 'secret/jenkins/aws', engineVersion: 2, secretValues: [
     [envVar: 'DEPLOYMENT_USERNAME', vaultKey: 'aws_access_id'],
     [envVar: 'DEPLOYMENT_PASSWORD', vaultKey: 'aws_secret_key']
    ]],
]
def azure_secrets = [
  [path: 'secret/jenkins/azure', engineVersion: 2, secretValues: [
     [envVar: 'CLIENT_ID', vaultKey: 'client_id'],
     [envVar: 'CLIENT_SECRET', vaultKey: 'client_secret'],
     [envVar: 'SUBSCRIPTION_ID', vaultKey: 'subscription_id'],
     [envVar: 'TENANT_ID', vaultKey: 'tenant_id']
		  
    ]],
]

def configuration = [vaultUrl: 'http://host.docker.internal:8200',  vaultCredentialId: 'vault_app_role', engineVersion: 2]

def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]
def loadValuesYaml(x){
  def valuesYaml = readYaml (file: './pipeline.yml')
  return valuesYaml[x];
}

pipeline {
    environment {
        
	    //credentials
	    dockerHubCredential = loadValuesYaml('dockerHubCredential')
            awsCredential = loadValuesYaml('awsCredential')
	    
	    //cloud provider
	    
	    cloudProvider = loadValuesYaml('cloudProvider')
	    
	    //docker config
	    imageName = loadValuesYaml('imageName')
	    slackChannel = loadValuesYaml('slackChannel')
	    dockerImage = ''
	    
	    //s3 config
            backendFile = loadValuesYaml('backendFile')
            backendPath = loadValuesYaml('backendPath')
	    
	    //additional external feedback
	    successAction = loadValuesYaml('successAction')
	    failureAction = loadValuesYaml('failureAction')  
	    app_url = ''
	    TF_CLI_CONFIG_FILE='/var/jenkins_home/.terraformrc' 
   }
    agent any
    stages {
        stage('Build Node App') {
            steps {
                echo 'Building Node app...'
                sh 'npm install-test'
                  }
        }
        stage('Build Docker Image') {
             steps {
                script{
                    echo 'Building Docker image...'
                    docker.withRegistry( '', dockerHubCredential ) {
          		dockerImage = docker.build imageName
		    }
                }
             }
        }
        stage('Deploy to Docker Hub') {
            steps {
               script {
             echo 'Publishing Image to Docker Hub...'
                    docker.withRegistry( '', dockerHubCredential ) {
                        dockerImage.push("$BUILD_NUMBER")
                        dockerImage.push('latest')                    }
                }
             }
        }
        stage('Cleanup Local Image') {
            steps {
               script {
                  echo 'Removing Image...'
                 
		    sh "docker rmi $imageName:$BUILD_NUMBER"
                    sh "docker rmi $imageName:latest"
                    }
                }
        }
        stage('Deploy Image to Cluster') {
            steps {
                script {

			if (cloudProvider == "AWS") {
	    		    secrets = aws_secrets
	    		    withVault([configuration: configuration, vaultSecrets: secrets]) {
				
			        //bootstrapping remote state backend for terraform
			        //dir("${env.WORKSPACE}/bootstrap"){
				//    echo 'Bootstrap logic...'
				//    sh 'chmod +x ./bootstrap.sh'	
				//    sh './bootstrap.sh'
			        //}
	            
	                        echo 'Provisioning to AWS...'
                                //sh 'cp /var/jenkins_home/.terraformrc .'
                                //sh 'terraform init -backend-config=\"access_key=$DEPLOYMENT_USERNAME\"  -backend-config=\"secret_key=$DEPLOYMENT_PASSWORD\"'
				sh 'terraform init'    
                                sh 'terraform plan -out=plan.tfplan -var deployment_username=$DEPLOYMENT_USERNAME -var deployment_password=$DEPLOYMENT_PASSWORD'
		                sh 'terraform apply -auto-approve plan.tfplan'
	                        app_url = sh (
			            script: "terraform output app_url",
                                    returnStdout: true
                                ).trim()   
		
                           }
		        }
			else if (cloudProvider == "AZURE"){
				
				 secrets = azure_secrets
	    		         withVault([configuration: configuration, vaultSecrets: secrets]) {
				
			            //bootstrapping remote state backend for terraform
			           // dir("${env.WORKSPACE}/bootstrap"){
				   //     echo 'Bootstrap logic...'
				   //     sh 'chmod +x ./bootstrap.sh'	
				   //     sh './bootstrap.sh'
			           // }
	            
	                            echo 'Provisioning to Azure...'
                   		//    sh 'cp /var/jenkins_home/.terraformrc .'
                                   // sh 'terraform init -backend-config=\"client_id=$CLIENT_ID\" -backend-config=\"client_secret=$CLIENT_SECRET\" -backend-config=\"tenant_id=$TENANT_ID\"  -backend-config=\"subscription_id=$SUBSCRIPTION_ID\"'
			            sh 'terraform init'    
                                
                                    sh 'terraform plan -out=plan.tfplan -var deployment_subscription_id=$SUBSCRIPTION_ID -var deployment_tenant_id=$TENANT_ID -var deployment_client_id=$CLIENT_ID -var deployment_client_secret=$CLIENT_SECRET'
		                    sh 'terraform apply -auto-approve plan.tfplan'
	                            app_url = sh (
			                script: "terraform output app_url",
                                        returnStdout: true
                                    ).trim()   
		
                               }
			
			}
                }
            }
        }
    stage('Post Deployment Test') {
     steps {
		   
		    sh 'newman run PostDeploymentTests/collection.json'
	    }
    }
	    
    stage('Tear Down') {
            steps {
		   
		    sh 'terraform destroy  -auto-approve'
	    }
    }
   
    }
    post { 
        success {
          
		slackSend channel:  "${slackChannel}",
          	color: COLOR_MAP[currentBuild.currentResult],
          	message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}\n APP_URL:${app_url}"
          
	  	sh "${successAction}"
        
        }
    
        failure {
	  	slackSend channel:  "${slackChannel}",
          	color: COLOR_MAP[currentBuild.currentResult],
          	message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}\n"
          
		sh "${failureAction}"
        
        }
    }
}
