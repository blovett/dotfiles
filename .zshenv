export PAGER=less
export LESS=-cex3M
export CVS_RSH=ssh
export RSYNC_RSH=ssh
export EDITOR=vim
export LEDGER_FILE=$HOME/Documents/ledger.txt
export JAVA_HOME=/Library/Java/Home

export EC2_HOME=$HOME/aws-stuff/ec2-api-tools
export EC2_AMITOOL_HOME=$HOME/ec2/ec2-ami-tools-1.3-49953
export EC2_PRIVATE_KEY=$HOME/aws-stuff/ben.key
export EC2_CERT=$HOME/aws-stuff/ben.crt

export AWS_ELB_HOME=~/aws-stuff/ElasticLoadBalancing-1.0.12.0
export AWS_IAM_HOME=~/aws-stuff/IAMCli-1.2.0
export AWS_CREDENTIAL_FILE=~/aws-stuff/account-key

path=($HOME/bin /usr/local/bin /usr/local/sbin /bin /usr/bin /sbin /usr/sbin)
path=($path  $AWS_IAM_HOME/bin $AWS_ELB_HOME/.bin $EC2_HOME/bin)
typeset -u path
