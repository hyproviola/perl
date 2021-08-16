#!/usr/bin/perl -w

# 
# A simple terminal text editor
# Its' only capability is writing text and exiting
#
# To Exit: Ctrl+Q and then click 'y' for yes
#
#
# Tutorial: man Curses::UI::Tutorial
#
#  Requires: Curses::UI

use strict;
use warnings;

use Curses::UI;
my $cui = new Curses::UI( -color_support => 1);

# Curses::UI::Menubar
my @menu = (
  { -label => 'File',
    -submenu => [
      {
        -label => 'Exit     ^Q',
        -value => \&exit_dialog
      }
    ]
  },
);

sub exit_dialog() {
  my $return = $cui->dialog(
    -message => "Do you really want to quit?",
    -title => "Exit",
    -buttons => ['yes', 'no'],
  );
  exit 0 if $return;
}

my $menu = $cui->add(
  'menu', 'Menubar',
  -menu => \@menu,
  -fg => "blue",
);

my $win1 = $cui->add(
  'win1', 'Window',
    -border => 1,
    -y => 1,
    -bfg => 'red',
);

my $texteditor = $win1->add(
  "text", "TextEditor",
    -text => "Here is some text.\n"
);

$cui->set_binding(sub {menu->focus()}, "\cX");
$cui->set_binding(\&exit_dialog, "\cQ");

$texteditor->focus();
$cui->mainloop();
