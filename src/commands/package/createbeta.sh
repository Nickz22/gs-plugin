PKG_ORG=$1
UPLOAD_MATCH_PATTERN="PackageUploadRequest has been enqueued. You can query the status using"
UPLOAD_RESPONSE_MATCH_PATTERN="Successfully uploaded package ["
create_beta_package(){
    if [[ -z $PKG_ORG || $PKG_ORG == *qa* || $PKG_ORG == *QA* ]]
    then 
        echo "please provide the Sequence PACKAGING ORG alias"
        exit
    fi
    auth_pkg_env
    auth_qa_env
    deploy_to_pkg_org
    create_beta_version
}
auth_pkg_env(){
    printf "<---- authorizing Sequence Packaging environment ---->\n"
    sfdx force:auth:jwt:grant --clientid $SFDX_CONSUMER_KEY_PKG_ORG --jwtkeyfile .keys/server.key \
    --username nick.zozaya@ringdna.com.sequencepkg --instanceurl https://login.salesforce.com/
}
auth_qa_env(){
    printf "<---- authorizing Sequence QA environment ---->\n"
    sfdx force:auth:jwt:grant --clientid $SFDX_CONSUMER_KEY_QA --jwtkeyfile .keys/server.key \
    --username qa@ringdnasequence.com --instanceurl https://login.salesforce.com/
        
}
deploy_to_pkg_org(){
    printf "<---- deployment to Sequence Packaging Org ---->\n"
    git checkout Sequence-QA
    git pull
    result=`sfdx force:source:deploy -p force-app -w 100 -o -u $PKG_ORG`
    if [[ $result == *"fail"* || $result == *"cancel"* ]]
    then 
        echo "deployment to packaging org failed"
        exit
    fi
}
create_beta_version(){
    printf "<---- creating package version ---->\n"                              
    response=`sfdx force:package1:version:create -u $PKG_ORG --name __BASH__TESTING__ --packageid 0336F000000B3Oh`
    parse="${response//$UPLOAD_MATCH_PATTERN/}"
    
    # check for successful upload 
     # every 10s for 1 hr
      # upload package to QA when done
    interval=10
    ((end_time=${SECONDS}+6000))
    while ((${SECONDS} < ${end_time}))
    do
        result=`$parse`
    if [[ $result == *uploaded* ]];
    then
        parse_version_id="${result//$UPLOAD_RESPONSE_MATCH_PATTERN/}"
        parse_version_id="${parse_version_id//"]"/}"
        printf "installing package with version ID: $parse_version_id to Sequence QA environment\n"
        sfdx force:package:install -p $parse_version_id -u qa@ringdnasequence.com -b 30 --noprompt -w 30
        exit 0
    else
        echo "waiting for beta package upload..."
    fi
    sleep ${interval}
    done
}
create_test_data(){
    sfdx force:apex:execute -f src/commands/package/apex/createTemplate.apex -u qa@ringdnasequence.com
    sfdx force:apex:execute -f src/commands/package/apex/createActions.apex -u qa@ringdnasequence.com
    sfdx force:apex:execute -f src/commands/package/apex/createSequence.apex -u qa@ringdnasequence.com
    sfdx force:apex:execute -f src/commands/package/apex/createCampaignSequence.apex -u qa@ringdnasequence.com
    sfdx force:apex:execute -f src/commands/package/apex/createManualSequence.apex -u qa@ringdnasequence.com
    sfdx force:apex:execute -f src/commands/package/apex/createCadenceActions.apex -u qa@ringdnasequence.com
    sfdx force:apex:execute -f src/commands/package/apex/updateSettings.apex -u qa@ringdnasequence.com
}

create_beta_package
create_test_data