# erl_playground

An OTP application to start coding without the boring stuff.

## Prerequisites
This project has been written for Mac and Linux environments, theoretically speaking it can run on any environment where a Erlang system is correcty installed, but consider that MS Windows and Erlang are not best buddies. Nowadays it is pretty easy to have Linux systems running in minutes using Virtual Machines, Containers, USB distro or simply double booting your laptop.

In case you use a Mac system, we strongly recommend using [homebrew](https://brew.sh/) to manage all your packages.

**OpenSSL**

Check the correct installation process for you environment.

**Erlang/OTP 21.3**

If you are on Mac, we strongly suggest using [kerl](https://github.com/kerl/kerl) to build and install the proper Erlang version on your system. For other environments you can easily find your installation package on [ErlangSolutions](https://www.erlang-solutions.com/).

## Build & Run

This is a [rebar3](https://www.rebar3.org/) project.

## Compile GPB

Google Protocol Buffer is automatically compiled starting from the included proto file.
[Here](https://developers.google.com/protocol-buffers/) you can find all the information about it.

## What you have out of the box
This is a playgrounf application that allows you to focus on the logic of your system, rather than the boring technical stuff. It includes a basic Erlang/OTP application structure with a TCP client and a TCP server.

# Candidate comments
I used Meistertask to organize the project development: 
https://www.meistertask.com/app/project/pEfXBfuL/call-center-application

I create an IR(Input Requirement) to represent the generic Project, one IR is blocked by SRSs(Software Requirement Specification).
SRS contain some info about the project about the behavior of what system must do. One SRS may contain more Tasks.
Tasks are technical task to do. 

This is my first work with erlangOtp, the first part was only for understand Erlang and for prepare functions for the project.
After that, I merge the example with my work

How use it:
1. rebar3 shell  -> start erlang
2. client:run(). -> start callcenter app
3. if you select option 1, system shows a random Joke
4. if you select option 2, system shows your call id
5. if you select option 3, you can insert input string or number, the system print your string and tell you if your number is even or odd 