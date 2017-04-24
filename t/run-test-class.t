#!/usr/bin/env perl

use File::Basename;
use File::Path;

use Test::Class::Moose::Load 'src/commands/TestsFor';
use Test::Class::Moose::Runner;

new Test::Class::Moose::Runner()->runtests;
