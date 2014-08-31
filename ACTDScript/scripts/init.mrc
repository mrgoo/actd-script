on 1:START:{
  echo $color(ctcp) Starting ST:ACTD mIRC Script $versionscript
  titlebar - ST:ACTD Script $versionscript
  echo $color(topic) Check out 12 $+ $urlscript $+  for regular updates to the ST:ACTD mIRC Script
  echo  $color(ctcp) *****
  echo Script Update by mrgoo on Stardate 11408.31
  echo Script Patched to Support mIRC Version 7.36
  echo Preinstalled openSSL Libraries. Script is now SSL Ready
  echo Added 2 new aliases /arcadia and /discon (for use with ZNC)
  echo Fixed Minor bug in ctcp Script. 
  echo    
  echo $color(ctcp) *****
  .reload -rs scripts\display.mrc
  .reload -rs scripts\rawmover.mrc
  .reload -rs scripts\services.mrc
  servicemodinit
  .reload -rs scripts\opercontrol.mrc
  opermodinit
  .reload -rs scripts\irc2html\irc2html.mrc
  .reload -rs scripts\aliases.mrc
  .reload -rs scripts\ctcp.mrc
  ctcpmodinit
  inithash topics
  echo $color(other) *****
  echo $color(info) ST:ACTD Script $versionscript is now fully loaded as of $stardate at $startime
  echo $color(other) *****

}
alias inithash {
  if ($hget($1) != $1 ) {
    hmake $1 10
  }
  else {
    echo $color(other) $1 hash table already exists, reinitializing
  }
  if ( $exists($1 $+ .hsh) == $true ) { hload $1 $1 $+ .hsh }
}
alias savehash {
  hsave -os $1 $1 $+ .hsh
}
alias versionscript {
  return $majorversion $+ . $+ $minorversion $+ . $+ $patchversion
}
alias majorversion {
  return 1
}
alias minorversion {
  return 0
}
alias patchversion {
  return 3
}
alias copyrightyear {
  return 2014
}
alias urlscript {
  return http://www.arcadiastation.com/
}
alias stardate {
  return $calc($asctime(yyyy) - 1900) $+ $asctime(mm) $+ . $+ $asctime(dd)
}
alias startime {
  return $asctime(HHnn.ss) hours
}
