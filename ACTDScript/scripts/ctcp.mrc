alias ctcpmodinit {
  echo $color(info) CTCP Module Loaded
}
ctcp *:MOTFV: {
  echo 2 -
  .ctcpreply $nick VERSION ST:ACTD Script Version $versionscript (mIRC $+ $bits $version by K.Mardam-Bey running on Windows $os $+ ) Copyright © $+ $copyrightyear 12 $+ $urlscript $+ 
  echo $color(ctcp) $timestamp ¢ ··· $nick VERSION $2-
  haltdef
}
ctcp *:VERSION:{
  echo 2 -
  .ctcpreply $nick VERSION ST:ACTD Script Version $versionscript (mIRC $+ $bits $version by K.Mardam-Bey running on Windows $os $+ ) Copyright © $+ $copyrightyear 12 $+ $urlscript $+ 
  echo $color(ctcp) $timestamp ¢ ··· $nick $1-
}
ctcp *:PING:{
  echo 2 -
  echo $color(ctcp) $timestamp ¢ ··· $nick $1- 
}
ctcp *:TIME:{
  echo 2 -
  .ctcpreply $nick TIME $stardate at $startime (ST:ACTD Script $versionscript $+ )
  echo $color(ctcp) $timestamp ¢ ··· $nick $1-
  halt
}
ctcp *:FINGER:{
  echo 2 -
  .ctcpreply $nick FINGER Like I'd tell you my name and address (ST:ACTD Script $versionscript $+ )
  echo $color(ctcp) $timestamp ¢ ··· $nick $1-
  halt
}
on *:CTCPREPLY:TIME*:{
  echo 2 -
  echo $color(ctcp) $timestamp ¢ $+ $nick replied to $1 $+ ¢ $2-
  haltdef
}
on *:CTCPREPLY:PING*:{
  echo 2 -
  if ( $3 isnum ) {
    echo $color(ctcp) $timestamp ¢ $+ $nick replied to $1 $+ ¢ $calc(( $ticks - $3 ) / 1000) seconds
    haltdef
  }
}
alias ping { .quote PRIVMSG $$1 :PING $ctime $ticks $+  }
alias ctcp {
  if ( PING isin $2- ) {
    .quote PRIVMSG $$1 :PING $ctime $ticks $+ 
  }
  else {
    ctcp $1 $2-
  }
}
on *:CTCPREPLY:*:{
  echo 2 -
  echo $color(ctcp) $timestamp ¢ $+ $nick replied to $1 $+ ¢ $2-
  haltdef
}
