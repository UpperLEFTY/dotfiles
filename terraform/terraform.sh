#!/bin/sh

# terraform helper functions
# You can either run them from the project root or from the /terraform directory

#
# Initialize terraform against a particular tfstate
# shellcheck disable=SC3044 

# Usage: tfinit <environment>
#
#

tfinit() {
  if [ -d "terraform" ]; then
    POP_TF="yes"
    # shellcheck disable=SC3044 
    pushd ./terraform || return
  fi

  if [ -z "$1" ]; then
    echo "Arg $1 should be environment!"
    return
  fi

  echo "Using profile test_$1"
  export AWS_PROFILE="test_$1"

  terraform "init -reconfigure -backend-config=config/backend-$1.conf"

  if [ -n "$POP_TF" ]; then
    POP_TF=''
    # shellcheck disable=SC3044 
    popd ... || exit
  fi
}

# 
# Run the expected execution plan
# 

# Usage: tfplan <environment>
#
#

tfplan() {
  if [ -d "terraform" ]; then
    POP_TF="yes"
    # shellcheck disable=SC3044 
    pushd ./terraform || return
  fi

  if [ -z "$1" ]; then
    echo "Arg $1 should be environment!"
    return
  fi

  echo "Using profile test_$1"
  export AWS_PROFILE="test_$1"

  terraform plan -var-file="config/$1.tfvars"

  if [ -n "$POP_TF" ]; then
    POP_TF=''
    # shellcheck disable=SC3044 
    popd || exit 
  fi
}

# 
# Destroy all resources
# 

# Usage: tfdestroy <environment>
#
#

tfdestroy() { 
  if [ -d "terraform" ]; then
    POP_TF="yes"
    # shellcheck disable=SC3044 
    pushd ./terraform || exit
    return
  fi

  if [ -z "$1" ]; then
    echo "Arg $1 should be environment!"
    return
  fi

  echo "Using profile test_$1"
  export AWS_PROFILE="test_$1"

  terraform destroy -var-file="config/$1.tfvars"

  if [ -n "$POP_TF" ]; then
    POP_TF=''
  # shellcheck disable=SC3044  
    popd  || exit
  fi
}

# 
# Apply the terraform execution plan with before/after timestamps
# 

# Usage: tfapply <environment>
#
#


tfapply() {
  if [ -d "terraform" ]; then
    POP_TF="yes"
    # shellcheck disable=SC3044 
    pushd ./terraform || return
  fi

  if [ -z "$1" ]; then
    echo "Arg $1 should be environment!"
    return
  fi

  echo "Using profile test_$1"
  export AWS_PROFILE="test_$1"

  echo "Apply started at $(date)"
  terraform apply -var-file="config/$1.tfvars"
  echo "Apply completed at $(date)"

  if [ -n "$POP_TF" ]; then
    POP_TF=''
    # shellcheck disable=SC3044 
    popd || exit
  fi
}

# 
# Import existing resources into your tfstate
# 

# Usage: tfimport <environment> <resource> <id>
#
#

tfimport() {
  if [ -d "terraform" ]; then
    POP_TF="yes"
    # shellcheck disable=SC3044 
    pushd ./terraform || return
  fi

  if [ -z "$1" ]; then
    echo "Arg $1 should be environment!"
    return
  fi
  if [ -z "$2" ]; then
    echo "Arg $2 should be the resource name!"
    return
  fi
  if [ -z "$3" ]; then
    echo "Arg $3 should be the ID of the resource to import!"
    return
  fi

  echo "Using profile test_$1"
  export AWS_PROFILE="test_$1"

  terraform import -var-file="config/$1.tfvars" "$2" "$3"

  if [ -n "$POP_TF" ]; then
    POP_TF=''
    # shellcheck disable=SC3044 
    popd || exit
  fi
}

# 
# Migrate your current state into a new state file
# 

# Usage: tfmigrate <environment>
#
#

tfmigrate() {
  if [ -d "terraform" ]; then
    POP_TF="yes"
    # shellcheck disable=SC3044 
    pushd ./terraform || return
  fi

  if [ -z "$1" ]; then
    echo "Arg $1 should be environment!"
    return
  fi

  echo "Using profile test_$1"
  export AWS_PROFILE="test_$1"

  terraform init -migrate-state -backend-config=config/backend-"$1".conf

  if [ -n "$POP_TF" ]; then
    POP_TF=''
    # shellcheck disable=SC3044 
    popd || exit
  fi
}
