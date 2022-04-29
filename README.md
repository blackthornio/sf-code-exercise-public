# Blackthorn.io Salesforce Developer Interview Coding Exercise

This repository contains a coding exercise for use in the hiring process for Salesforce developers at Blackthorn. The intent of this exercise is to test several key areas of the candidates capabilities:
* Knowledge of Test Driven Development (TDD)
* Software Patterns (e.g., Pub/Sub)
* Use of common development tools (e.g., Git)
* Ability to work asynchronously on a coding problem of medium difficulty

## Pub/Sub Pattern

The idea behind the exercise is to complete the service layer of a simple [pub/sub pattern](https://www.enterpriseintegrationpatterns.com/patterns/messaging/PublishSubscribeChannel.html) along with an implementation of an interface to handle emitted messages on a channel.

## Instructions for Candidates

* The ultimate goal of this task is to complete the pub/sub service layer and implementation of the ```IHandleMessages``` interface.
    * The implementation (```IncomingLeadHandler```) should handle messages on its subscribed channel and insert any _valid_ leads handled.
    * For purposes of this exercise, we will consider any lead to be valid if it has a ```FirstName``` which is not ```null```.
* To get started, check out the repository to your local machine and use your favorite Salesforce capable IDE.
* Complete the implementations of all incomplete methods in the following classes:
    * ```PubSubService``` should be implemented as a generic service which is capable of handling multiple implementations of ```IHandleMessages``` on as many subscriber channels as desired.
    * ```IncomingLeadHandler```
* ```IncomingLeadHandlerTest```, ```PubSubServiceTest``` contain integration tests which should pass if the implementation is to specification.
    * Do not modify these test classes of this library in any way.
    * The tests make no assumptions about coding style or how you go about implementing the task, just that the outlined goals are achieved.
    * The only strict expectations are outlined in the method Apex Docs. The rest is up to you!
* This exercise is open book and you may use any resources online you wish to.
* When completed, push the solution to a Git repository of your own (Bitbucket, Github, GitLab, etc.) and provide the URL to your interviewer.
    * You may provide any notes, video descriptions or discussion, or other reference material you find helpful if you choose as well.