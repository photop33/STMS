pipeline {
    agent any
    stages {
        stage('VAGRANT UP') {
            steps {
              ''' bat vagrant up
                  bat vagrant ssh'''
            }
        }
        stage('VAGRANT UP') {
          steps {
            ''' bat sudo ansible-playbook playbook.yaml'''
          }
        }
  
