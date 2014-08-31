on ^*:TEXT:*:#ST*,#ACTD*,#7thChevron-*,#7thChevronTrainingCenter,%OOMRoom:{
  set %vo-op $vo-op($nick,$chan)
  var %nickcolor = $PickNickColor($nick)
  var %longnick = $replace($nick,_, )
  set %posmatch $mypos $+ :
  if ( %posmatch isin $1- ) {
    AlertWin $timestamp  $+ %nickcolor $+ %longnick $+  Mentioned your position in $chan
    window -g2 $chan
  }
  if ( $myname isin $1- ) {
    AlertWin $timestamp  $+ %nickcolor $+ %longnick $+  Mentioned your name in $chan
    window -g2 $chan
  }
  if ( $me isin $1- ) {
    AlertWin $timestamp  $+ %nickcolor $+ %longnick $+  Mentioned your nickname in $chan
    window -g2 $chan
  }
  echo $chan  $+ %nickcolor $+ %vo-op $+ %longnick $+ :
  echo $chan %vo-op $+ $1-
  echo $chan  
  haltdef
}
on *:INPUT:#:{
  if ((ACTD isin $chan) || ($chan == %OOMRoom) || (ST_ isin $chan) || (7thChevron-Rated isin $chan) || (7thChevronTrainingCenter isin $chan)) {
    set %vo-op $vo-op($me,$chan)
    var %nickcolor = $PickNickColor($me)
    var %longnick = $replace($me,_, )
    if ($isleftslash($$1) == 0) {
      echo $chan  $+ %nickcolor $+ %vo-op $+ $charcode($chan) $+ %longnick $+ :
      echo $chan %vo-op $+ $charcode($chan) $+ $1-
      echo $chan  
      haltdef
      .msg $chan $charcode($chan) $+ %awaychar $+ $$1-
      if (($left($1,1) == @) || ($left($1-,1) == #) || ($left($1-,1) == $) || ($left($1-,1) == %) || ($left($1-,1) == ^) || ($left($1-,1) == &)) {
        /editbox $chan $left($1,1)
      }
    }
    if ( $$1 == /me ) {
      echo %nickcolor $chan %vo-op $+ $charcode($chan) $+ %longnick $+ :
      echo $chan %vo-op $+ $charcode($chan) $+ :: $+ $2- $+ ::
      echo $chan  
      haltdef
      .msg $chan $charcode($chan) $+ :: $+ $$2- $+ ::
    }
    unset %vo-op
    unset %nickcolor
    unset %longnick
  }
}
alias charcode {
  if ((($mypos == CO) && ($vo-op($me,$1) != $chr(2))) || (%tempsm == 1)) {
    return %charcode $chr(2)
  }
  else {
    return $null
  }
}
alias isleftslash {
  if ($left($1-,1) == /) {
    return 1
  }
  else {
    return 0
  }
}
alias AlertWin {
  if ( $window( @ALERTS ) == $null ) {
    window -dsg2k0CRo @ALERTS 0 0 600 100
  }
  flash -r1 $1-
  echo @ALERTS $1-
}

alias alert {
  if ( $1 == red ) {
    background -l redalert.bmp
    background -h redalert.bmp
    AlertWin 4RED ALERT!!!
    splay sounds/ralert.wav
  }
  elseif ( $1 == yellow ) {
    background -l yellowalert.bmp
    background -h yellowalert.bmp
    AlertWin 8,1YELLOW ALERT!!!
    splay sounds/ralert.wav
  }
  elseif ( $1 == blue ) {
    background -l bluealert.bmp
    background -h bluealert.bmp
    AlertWin 12BLUE ALERT!!!
    splay sounds/ralert.wav
  }
  else {
    background -l conditiongreen.bmp
    background -h conditiongreen.bmp
    AlertWin 3Alert Cancelled... Condition Green
  }
}


alias SelfHighlighter {

}

alias PickNickColor {
  return $cnick($1).color
}

alias mypos {
  var %uscorepos = $pos($me,_,1)
  var %epos = $calc(%uscorepos - 1)
  return $left($me , %epos)
}

alias myname {
  var %uscorepos = $pos($me,_,1)
  var %epos = $calc(%uscorepos + 1)
  return $mid($me , %epos)
}

alias npos {
  var %uscorepos = $pos($1,_,1)
  var %epos = $calc(%uscorepos - 1)
  return $left($1 , %epos)
}

alias vo-op {
  unset %vo-op
  if $1 isvo $2 { set %vo-op  }
  if $1 ishop $2 { set %vo-op  }
  if $1 isop $2 { set %vo-op  }
  return %vo-op
}
menu channel {
  -
  SetOOM
  .ON:/set %OOMRoom $chan
  .OFF:/unset %OOMRoom
  Set Temp SM
  .ON:/set %tempsm 1
  .OFF:/set %tempsm 0
}
