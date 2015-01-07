This repository was created to reproduce an issue with puma phased restarts.

## Description
When performing a phased restart whilst there is a long running request in progress (20 seconds in this example), 
the puma master process unexpectedly dies and does not recover. 

## Environment

 - Ruby 2.1.5 MRI
 - Rails 4.1.7
 - Puma 2.10.2
 - [Puma configuration](config/puma.rb)
 
## Test Description
This repository is a bare bone rails application the has one controller and action to return the string 
'Hello' after sleeping for 20 seconds.

The test sequence is as follows:

- Start Puma
- Execute GET request (which sleeps for 20 seconds before returning)
- Initiate a phased restart
- View the puma log to observe the master process dying

These test steps are defined in [error.sh](error.sh)

A typical log output looks like the following:

```
=== puma startup: 2015-01-08 10:12:00 +1100 ===
[46981] + Gemfile in context: /home/adam/dev/repos/puma-issue/Gemfile
[46972] + Gemfile in context: /home/adam/dev/repos/puma-issue/Gemfile
[46964] - Worker 0 (pid: 46972) booted, phase: 0
[46964] - Starting phased worker restart, phase: 1
[46964] + Changing to /home/adam/dev/repos/puma-issue
[46964] - Worker 1 (pid: 46981) booted, phase: 0
[46964] - Stopping 46972 for phased upgrade...
[46964] - TERM sent to 46972...
[46972] ! Detected parent died, dying
[46981] ! Detected parent died, dying
```

**Note: When removing the sleep from the Controller, the phased restart workers as expected**

## Instructions to reproduce

```
  $ git clone git@github.com:davoad/puma-issue.git
  $ cd puma-issue
  $ bundle install
  $ . ./error.sh
```
