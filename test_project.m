clear; clc
warning ('off');
warning('not'); 
lastwarn('')
[msg,warnId] = lastwarn
warning ('on');
warning('not2');

warning ('off');
warning('not'); 
warning ('on');
warning('not2');