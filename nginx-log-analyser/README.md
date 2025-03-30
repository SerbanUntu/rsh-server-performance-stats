# Nginx Log Analyser

A script that analyses the logs from an Nginx log file.

## Instructions

1. Clone the repository using SSH
  ```
  git clone git@github.com:SerbanUntu/rsh-devops.git
  cd nginx-log-analyser
  ```
2. Grant execute permissions to the script
  ```
  chmod u+x ./analyse-log.sh
  ```
3. Download the log file
  ```
  curl -L https://gist.githubusercontent.com/kamranahmedse/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log -o logfile.txt
  ```
4. Run the script 
  ```
  ./analyse-log.sh
  ```

Part of the DevOps track on [roadmap.sh](https://roadmap.sh/projects/nginx-log-analyser)

