#!/usr/bin/env perl

use File::Basename;

use Test::Class::Moose::Load dirname (__FILE__).'/commands';
use Test::Class::Moose::Runner;

new Test::Class::Moose::Runner()->runtests;
