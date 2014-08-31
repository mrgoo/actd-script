alias opermodinit {
  inithash onicks
  inithash opass
  .disable #opercontrol
  .disable #opers
  echo $color(info) Oper Module Loaded
}
on 1:CONNECT:{
  operup
}
#operctrl off

menu nicklist {
  Control
  .Kill:/kill $1 $1
  .Kill (why?):/kill $1 $$?="Why kill $1?"
  .-
  .GLine
  ..Block:/os block $1
  oper
  .Kill:/kill $1 $1
  .Kill (why?):/kill $1 $$?="Why kill $1?"
  .-
  .GLine
  ..Block:/os block $1

}
menu channel,status,menubar {
  -
  oper
  .Rehash:/rehash
  .$iif( a isin $usermode,Kill IRCd)
  ..$iif(a isin $usermode,OK!):/die $?="What is the kill pass?"
  .$iif( a isin $usermode,Restart IRCd)
  ..$iif(a isin $usermode,OK!):/restart $?="What is the restart pass?"
  .-
  .Connect Server:/connect $$?="Enter Server to connect, port to connect on, and optionally server to connect to"
  .Squit Server:/squit $$?="Which server to squit and why?"
  .-
  .Send Message via
  ..Wallops:/wallops $$?="What message to send via wallops?"
  ..-
  ..Globops:/globops $$?="What message to send globops?"
  ..Locops:/locops $$?="What message to send locops?"
  ..Chatops:/chatops $$?="What message to send to chatops?"
}
menu @WALLOPS,@SNOTICE {
  -
  Rehash:/rehash
  $iif(a isin $usermode,Kill IRCd)
  .$iif(a isin $usermode,OK!):/die $?="What is the kill pass?"
  $iif(a isin $usermode,Restart IRCd)
  .$iif(a isin $usermode,OK!):/restart $?="What is the restart pass?"
  -
  Connect Server:/connect $$?="Enter Server to connect, port to connect on, and optionally server to connect to"
  Squit Server:/squit $$?="Which server to squit and why?"
  -
  Send Message via
  .Wallops:/wallops $$?="What message to send via wallops?"
  .-
  .Globops:/globops $$?="What message to send globops?"
  .Locops:/locops $$?="What message to send locops?"
  .Chatops:/chatops $$?="What message to send to chatops?"
}

#operctrl end
alias enableopercmds {
  .enable #operctrl
  .enable #opers
  set %operon 1
}
alias disableopercmds {
  .disable #operctrl
  .disable #opers
  unset %operon
}
on *:USERMODE:{
  isanoperchk
}
on *:DISCONNECT:{
  disableopercmds
}
alias isanoperchk {
  if (o isin $usermode) {
    echo $color(info) -s Oper Status detected for $me $+ ... Enabling Oper Controls
    enableopercmds
  }
  else {
    if (%operon == 1) {
      echo $color(info) -s Oper Status on $me removed... Disabling Oper Controls
    }
    disableopercmds
  }
}
alias operup {
  if ( $hget(onicks,$server) != $null ) {
    .oper $hget(onicks , $server) $hget(opass, $server)
  }
}
alias operadd {
  echo 7 Adding information for oline on server: $server
  hadd -s onicks $server $1
  hadd -s opass $server $2
  savehash onicks
  savehash opass
}
alias operdel {
  echo 7 Deleting information for oline on server: $server
  hdel -s onicks $server
  hdel -s opass $server
  savehash onicks
  savehash opass
}
