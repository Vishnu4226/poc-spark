node{
   
    stage('git checkout'){
        git credentialsId: 'c7ec11f8-be14-4db2-85a9-589b52864e9a', url: 'https://github.com/Vishnu4226/poc-spark.git'
    }
    stage('Sonar'){
        
            sh'''
            #sbt clean package -Dsonar.projectKey=hmpoc -Dsonar.projectName=hmpoc -Dsonar.host.url=http://52.87.201.133:9000 -Dsonar.login='admin' -Dsonar.password='admin' sonarScan
            #sbt clean package  -Dproject.settings=./sonar-project.properties -Dsonar.login='admin' -Dsonar.password='admin' sonarScan
            sbt clean package  
            '''
            /*withSonarQubeEnv(installationName: 'SonarQubeServer') {
                sh "sonar-scanner"
            }*/ 
            sh "sonar-scanner"
    }
    stage('Upload'){
        dir('/var/lib/jenkins/workspace/Poc-Spark-EKS/target/scala-2.11/')
        {
             s3Upload consoleLogLevel: 'INFO', dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 'pocsparkeks/$JOB_NAME:$BUILD_NUMBER.jar', excludedFile: '', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: false, noUploadOnFailure: true, selectedRegion: 'ap-south-1', showDirectlyInBrowser: false, sourceFile: '*.jar', storageClass: 'STANDARD', uploadFromSlave: false, useServerSideEncryption: false, userMetadata: [[key: 'Name', value: '$PROJECT_$BUILD_NUBER']]]], pluginFailureResultConstraint: 'SUCCESS', profileName: 'awscredentials', userMetadata: []   
        
        }
    }
    stage('build'){
        sh'''
        $(aws ecr get-login --no-include-email --region ap-south-1)
        docker login -u vishnu4772 -p Vishnu@522
        docker build -t poc-spark-eks .
        docker tag poc-spark-eks:latest 010050280358.dkr.ecr.ap-south-1.amazonaws.com/poc-spark-eks:$BUILD_NUMBER
        '''
    }
    stage('Docker push'){
        docker.withRegistry('https://010050280358.dkr.ecr.ap-south-1.amazonaws.com/poc-spark-eks', 'ecr:ap-south-1:AWSCredentials') {
            docker.image('010050280358.dkr.ecr.ap-south-1.amazonaws.com/poc-spark-eks:$BUILD_NUMBER').push('$BUILD_NUMBER')
        }
    }
    stage('EKS Deployment'){
        sh'''
        #kubectl delete deployment poc-deployment
        #kubectl delete service poc-service
        #sed 's/latest/'${BUILD_NUMBER}'/g' Dep.yaml
        chmod +x ChangeTag.sh
        ./ChangeTag.sh ${BUILD_NUMBER}  
        kubectl create -f DeloymentNew.yaml
        '''
    }
}
