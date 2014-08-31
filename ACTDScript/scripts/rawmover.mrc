raw 1:*:{
  echo $color(self)  $+ $color(normal) $+ ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• $+ $color(normal) $+ •
  if (( $6 == Internet ) && ( $7 == Relay ) && ( $8 == Chat )) {
    echo $color(info) Welcome to the  $+ $5 $+  Chat network  $+ $10- $+ !
  }
  elseif ( $6 == IRC ) {
    echo $color(info) Welcome to the  $+ $5 $+  Chat Network  $+ $8- $+ !
  }
  else {
    echo $color(info)  $+ $2-
  }
  haltdef
}
raw 2:*:{
  echo $color(info) Your host is  $+ $5 $+  running  $+ $8- $+ 
  haltdef
}
raw 3:*:{
  echo $color(info) This Server was compiled:  $+ $6- $+ .
  haltdef
}
raw 4:*:{
  echo $color(info) Server Conf:  $+ $3- $+ 
  haltdef
}
raw 251:*:{
  echo $color(self)  $+ $color(normal) $+ ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• $+ $color(normal) $+ •
  if ($4 == 1) {
    set %lu.users user
  }
  else {
    set %lu.users users
  }
  if ($7 == 1) {
    set %lu.invisible invisible user
  }
  else {
    set %lu.invisible invisible users
  }
  if ($calc($7 + $4) == 1) {
    set %lu.totalu total user
  }
  else {
    set %lu.totalu total users
  }
  if ( bots isin $10 ) {
    if ($mid($9,2) == 1) {
      set %lu.bots a bot
    }
    else {
      set %lu.bots bots
    }
    if ($12 == 1) {
      set %lu.servers server
    }
    else {
      set %lu.servers servers
    }
    echo $color(info) There are  $+ $4 $+  %lu.users and  $+ $7 $+  %lu.invisible ( $+ $calc($4 + $7) $+  %lu.totalu $+ ) ( $+ $mid($9,2) $+  of them %lu.bots $+ ) on  $+ $12 $+  %lu.servers $+ .
  }
  else {
    if ($10 == 1) {
      set %lu.servers server
    }
    else {
      set %lu.servers servers
    }
    echo $color(info) There are  $+ $4 $+  %lu.users and  $+ $7 $+  %lu.invisible ( $+ $calc($4 + $7) $+  %lu.totalu $+ ) on  $+ $10 $+  %lu.servers $+ .
  }
  unset %lu.*
  haltdef
}
raw 252:*:{
  if ( $2 == 0 ) {
    echo $color(info) No operators are online.
  }
  elseif ( $2 == 1 ) {
    echo $color(info) 1 operator is online.
  }
  else {
    echo $color(info)  $+ $2 $+  operators are online.
  }
  haltdef
}
raw 254:*:{
  if ($2 == 0) {
    echo $color(info) No channels formed.
  }
  elseif ($2 == 1) {
    echo $color(info) 1 channel formed.
  }
  else {
    echo $color(info)  $+ $2 $+  channels formed.
  }
  haltdef
}
raw 255:*:{
  if ($4 == 1) {
    set %lu.clients client
  }
  else {
    set %lu.clients clients
  }
  if ($7 == 1) {
    set %lu.servers server
  }
  else {
    set %lu.servers servers
  }
  echo $color(info) I have  $+ $4 $+  %lu.clients and  $+ $7 $+  %lu.servers $+ .
  unset %lu.*
  haltdef
}
raw 265:*:{
  if (!%dotflagg) {
    echo $color(self)  $+ $color(normal) $+ ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• $+ $color(normal) $+ •
  }
  set -u5 %dotflagl 1
  echo $color(info) Current Local Users:  $+ $5 $+  Max:  $+ $7 $+ 
  if (%dotflagg) {
    echo $color(self)  $+ $color(normal) $+ ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• $+ $color(normal) $+ •
  }
  haltdef
}
raw 266:*:{
  if (!%dotflagl) {
    echo $color(self)  $+ $color(normal) $+ ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• $+ $color(normal) $+ •
  }
  set -u5 %dotflagg 1
  echo $color(info) Current Global Users:  $+ $5 $+  Max:  $+ $7 $+ 
  if (%dotflagl) {
    echo $color(self)  $+ $color(normal) $+ ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• $+ $color(normal) $+ •
  }
  haltdef
}

raw 375:*muh version*:{
  if ( $window( @MOTD ) != $null ) {
    close -@ @MOTD
  }
  window -ag1k0x @MOTD /echo @MOTD Message Of The Day
  font @MOTD 12 Fixedsys
  echo $color(info) @MOTD Message of the Day for $server
  tempparam muhvers $5
  muhon
  echo @MOTD  $+ $color(highlight) $+  $+ $3-
}
raw 375:*:{
  if ( $window( @MOTD ) != $null ) {
    close -@ @MOTD
  }
  window -ag1k0x @MOTD /echo @MOTD Message Of The Day
  font @MOTD 12 Fixedsys
  echo $color(info) @MOTD Message of the Day for $server
  echo $color(normal) @MOTD $3-
}
#nonmuh on
on ^*:SNOTICE:*:{
  snoticeparse $1-
  haltdef
}
#nonmuh end

alias snoticeparse {
  if ( $window( @SNOTICE ) == $null ) {
    window -aeg1k0 @SNOTICE
    font @SNOTICE 12 Times New Roman
  }
  if ( ( $4 == Client ) && ( ( $5 == connecting: ) || ( $5 == exiting: ) ) ) {
    if ( $5 == connecting: ) {
      echo $color(join) @SNOTICE $timestamp • (c) ••• - $+ $shortsname($nick) $+ - Connect:  $6 $boldparens($7-)
    }
    else {
      echo $color(ctcp) @SNOTICE $timestamp • (c) ••• - $+ $shortsname($nick) $+ - Exit:  $6 $boldparens($7-)
    }
  }
  elseif ( ( $6 == is ) && ( $7 == now ) && ( $8 == operator ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (o) ••• - $+ $shortsname($nick) $+ - $4 $boldparens($5) has opered $boldparens($9)
  }
  elseif ( ( $6 == is ) && ( $7 == now ) && ( $8 == operator ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (o) ••• - $+ $shortsname($nick) $+ - Oper:   $+ $PickNickColor($4) $+ $4 $+  $boldparens($5) has opered $boldparens($9)
  }
  elseif ( $5 == SQUIT ) {
    echo $color(quit) @SNOTICE $timestamp • (q) ••• - $+ $shortsname($nick) $+ - SQUIT:  $shortsname($6) from $shortsname($8)
  }
  elseif ( ( $4 == Net ) && ( ( $5 == break: ) || ( $5 == junction: ) ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (n) ••• - $+ $shortsname($nick) $+ -  $+ $5 $+  $shortsname($6) <=> $shortsname($7) $boldparens($8-)
  }
  elseif ( ( $2 == Connecting ) && ( $3 == to ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (n) ••• - $+ $shortsname($nick) $+ - Connecting to: $boldparens($4-)
  }
  elseif ( ( $1 == Link ) && ( $4 == established. ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (n) ••• - $+ $shortsname($nick) $+ - Link Established: $boldparens($3)
  }
  elseif ( ( $4 == Completed ) && ( $5 == net.burst ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (n) ••• - $+ $shortsname($nick) $+ - Net.Burst Complete: $boldparens($7-)
  }
  elseif ( ( $5 == acknowledged ) && ( $6 == end ) && ( $8 == net.burst. ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (n) ••• - $+ $shortsname($nick) $+ - End of Net Burst: $4 Acknowledged.
  }
  elseif ( ( $5 == KILL ) && ( $10 == NickServ ) ) {
    echo $color(quit) @SNOTICE $timestamp • (k) ••• - $+ $shortsname($nick) $+ - NickServ KILL: $8 $boldparens($10-)
  }
  elseif ( $5 == KILL ) {
    echo $color(quit) @SNOTICE $timestamp • (k) ••• - $+ $shortsname($nick) $+ - KILL: $8 by $boldparens($10-)
  }
  elseif ( ( $5 == adding ) && ( $6 == GLINE ) ) {
    echo $color(quit) @SNOTICE $timestamp • (g) ••• - $+ $shortsname($nick) $+ - GLINE: $shortsname($4) adding GLINE for $8 expiring on $asctime($remove($11,:),dddd mmmm dd), $asctime($remove($11,:),yyyy HH:nn:ss) ( $+ $12- $+ )
  }
  elseif ( ( $5 == removing ) && ( $6 == GLINE ) ) {
    echo $color(quit) @SNOTICE $timestamp • (g) ••• - $+ $shortsname($nick) $+ - GLINE: $shortsname($4) Removing GLINE for $8
  }
  elseif ( ( $1 == *** ) && ( $2 == Looking ) && ( hostname isin $4- )) {
    echo $color(wallops) @SNOTICE $timestamp • (p) ••• - $+ $shortsname($nick) $+ - CONNECTION CHECK: Hostname lookup...
  }
  elseif ( ( $1 == *** ) && ( $2 == Found ) && ( $4 == hostname ) ) {
    echo $color(join) @SNOTICE $timestamp • (p) ••• - $+ $shortsname($nick) $+ - CONNECTION CHECK: Hostname found!
  }
  elseif ( ( $1 == *** ) && ( $2 == Checking) && ( ident isin $3 ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (p) ••• - $+ $shortsname($nick) $+ - CONNECTION CHECK: Checking identd...
  }
  elseif ( ( $1 == *** ) && ( $2 == Checking ) && ( ( $5 == socks ) || ( wingate isin $3 ) ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (p) ••• - $+ $shortsname($nick) $+ - CONNECTION CHECK: Socks Proxy Check...
  }
  elseif ( ( $1 == *** ) && ((( $2 == Proxy ) && ( $3 == test ) && ( $4 == passed)) || (($2 == No) && ( $3 == socks ) && ( $4 == server) && ($5 == found))) ) {
    echo $color(join) @SNOTICE $timestamp • (p) ••• - $+ $shortsname($nick) $+ - CONNECTION CHECK: Proxy Test Passed!
  }
  elseif ( ( $1 == *** ) && ( ( $2 == Got ) || ( $2 == Received ) ) && ( ident isin $3 ) ) {
    echo $color(join) @SNOTICE $timestamp • (p) ••• - $+ $shortsname($nick) $+ - CONNECTION CHECK: Identd found!
  }
  elseif ( ( $1 == *** ) && ( $15 == pong ) && ( $19 == pong ) ) {
    echo $color(ctcp) @SNOTICE $timestamp • (P) ••• - $+ $shortsname($nick) $+ - If you are having problems connecitng due to ping timeouts, please type  $+ $14 $15 $16 $+  or  $+ $18 $19 $20 $+  now.
  }
  elseif ( ( $3 == -- ) && ( $4 == from ) ) {
    var %opnonnick = $rightcolon($5)
    echo $color(wallops) @SNOTICE $timestamp • ( $+ $left($2,1) $+ ) ••• $2 ••• - $+ $PickNickColor(%opnonnick) $+ %opnonnick $+ - $6-
  }
  elseif ( ( $2 == notice ) && ( rehash isin $6 ) && ( $7 == server ) ) {
    echo $color(wallops) @SNOTICE $timestamp • (r) ••• - $+ $shortsname($nick) $+ - REHASH by  $+ $PickNickColor($4) $+ $4 $+ .
  }
  else {
    echo $color(wallops) @SNOTICE $timestamp • (s) ••• - $+ $shortsname($nick) $+ - $$1-
  }
}
on ^*:WALLOPS:*:{
  if ( $window( @WALLOPS ) == $null ) {
    window -aeg1k0 @WALLOPS /wallops 
    font @WALLOPS 12 Times New Roman
  }
  if ( ( $2 == is ) && ( $3 == now ) && ( $4 == operator ) ) {
    echo $color(wallops) @WALLOPS $timestamp • (o) ••• ! $+ $shortsname($nick) $+ !  $+ $PickNickColor($1) $+ $1 $+  has opered $boldparens($5-)
  }
  elseif ( ( $1 == Failed ) && ( $2 == OPER ) && ( $3 == attempt ) ) {
    echo $color(ctcp) @WALLOPS $timestamp  • (o) ••• ! $+ $shortsname($nick) $+ !  $+ $PickNickColor($5) $+ $5 $+  has Failed to oper $boldparens($6-)
  }
  else {
    echo $color(wallops) @WALLOPS $timestamp • (w) ••• ! $+  $+ $PickNickColor($nick) $+ $shortsname($nick) $+ ! $$1-
  }
  haltdef
}

raw 372:*you have messages waiting. (read them with /muh read)*:{
  if ( $window( @MOTD ) == $null ) {
    font -ag1k0 @MOTD /echo @MOTD Message Of The Day
    font @MOTD 12 Times New Roman
  }
  echo @MOTD  $+ $color(highlight) $+ $3-
  enable #muh
  disable #nonmuh
  echo -s  $+ $color(info) $+ Muh 2.05d enhancements enabled.
  mode $me
  muh read
  haltdef
}
raw 372:*:{
  if ( $window( @MOTD ) == $null ) {
    window -ag1k0 @MOTD /echo @MOTD Message Of The Day
    font @MOTD 12 Times New Roman
  }
  echo $color(normal) @MOTD   $3-
  haltdef
}
raw 376:*:{
  if ( $window( @MOTD ) == $null ) {
    window -ag1k0 @MOTD /echo @MOTD Message Of The Day
    font @MOTD 12 Times New Roman
  }
  echo $color(info) @MOTD End $server MOTD
}
raw 311:*:{
  if ( $window( @WHOIS ) == $null ) {
    window -aeg1k0 @WHOIS /whois
    font @WHOIS 12 Times New Roman
    echo $color(self) @WHOIS  $+ $color(normal) $+ ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• $+ $color(normal) $+ •
  }
  var %wnickcolor = $PickNickColor($2)
  echo $color(info) @WHOIS  $+ %wnickcolor $+ $2 $+  is 1 $+ $2 $+ !1 $+ $3 $+ @1 $+ $4
  echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  is 1 $+ $leftcolon($6-)
  set %WhoisLAST $2
  haltdef
}
raw 312:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  is connecting on server  $+ $color(normal) $+  $+ $3 $+  ( $+  $+ $color(normal) $+  $+ $leftcolon($4-) $+  $+ )
    haltdef
  }
}
raw 313:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+   $+ $color(normal) $+ $leftcolon($3-)
    haltdef
  }
}
raw 317:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  has been idle for  $+ $color(normal) $+  $+ $duration( $3 )
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  has been online since  $+ $color(normal) $+ $tndatec($4) at $+ $color(normal) $+  $tntimec( $4 , 1 ) 
    haltdef
  }
}
raw 318:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(self) @WHOIS  $+ $color(normal) $+ ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••• $+ $color(normal) $+ •
    unset %WhoisLAST
    haltdef
  }
}
raw 319:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  is on the  $+ $color(normal) $+  $+ $leftcolon($3-) $+  channels
    haltdef
  }
}
raw 379:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  $3  $+ $color(normal) $+  $+ $4-
    haltdef
  }
}
raw 378:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  is 1 $+ $4-
    haltdef
  }
}
raw 310:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  is 1 $+ $4-
    haltdef
  }
}
raw 307:*:{
  if ( $window( @WHOIS ) != $null ) {
    echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  is 1 $+ $4-
    haltdef
  }
}
raw 301:*:{
  if ( %WhoisLAST == $2 ) {
    if ( $window( @WHOIS ) != $null ) {
      echo $color(info) @WHOIS  $+ $color(background) $+ $2 $+  is away: 1 $+ $3-
    }
  } 
  else {
    if ( %LastAway != $2 ) {
      echo $color(info)  $+ $color(normal) $+ $2 $+  is away: 1 $+ $3-
      set -u40 %LastAway $2
    }
  }
  haltdef
}
raw 332:*:{
  echo $color(topic) $2 $timestamp *** Topic in $2 is " $+ $leftcolon($3-) $+ ".
  hadd topics $chan $3-
  savehash topics
  haltdef
}
raw 333:*:{
  echo $color(topic) $2 $timestamp *** Topic set on $tndatec($4) at $tntimec( $4 , 1 ) hours by $3
  haltdef
}
raw 315:*:{
  ;colornicklist
}
