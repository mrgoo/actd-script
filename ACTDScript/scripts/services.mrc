alias servicemodinit {
  inithash npass
  echo $color(info) Services Module Loaded
}
on CSBot:INVITE:#:{
  join $chan
}
on OSBot:INVITE:#:{
  join $chan
}
on NBot:INVITE:#:{
  join $chan
}
on NBot:NOTICE:*is a registered nick*:*:{
  if ( $hget(npass, $me ) != $null ) {
    identify $hget(npass, $me )
  }
  else {
    setnspw
  }
}
on NBot:NOTICE:*nickname is registered*:*:{
  if ( $hget(npass, $me ) != $null ) {
    identify $hget(npass, $me )
  }
  else {
    setnspw
  }
}
dialog nickservset {
  title "Nickserv Password"
  size -1 -1 160 100
  text "Password: ", 15 , 10 10 140 20, center
  edit "", 1, 10 30 140 22, result autohs 
  button "OK", 101, 10 60 140 25, OK default 
}
on *:DIALOG:nickservset:sclick:101:{
  hadd npass $me $did(nickservset,1)
  savehash npass
  identify $hget(npass,$me)
}
on *:DIALOG:nickservset:init:*:{
  did -o nickservset 15 1 Password for $me $+ :
}
alias setnspw {
  /dialog -m nickservset nickservset
}
alias delnspw {
  hdel -s npass $me
  savehash npass
}
alias delnspwfor {
  hdel -s npass $$1
  savehash npass
}
alias NReauth {
  if ( $hget(npass, $me ) != $null ) {
    identify $hget(npass, $me )
  }
  else {
    setnspw
  }
}
menu channel {
  ChanServ
  .Self Op:/cs up $chan
  .Self Deop:/cs down $chan
  Nickserv
  .Set NSAutoAuth:/setnspw
  .Delete NSAutoAuth:/delnspw
  .Delete NSAutoAuth for another nick:/delnspwfor $$?="What nickname to delete auto-auth for?"
  .Link another nick to this one:/ns link $$?="What nickname would you like to link to $me $+ ?"
}
menu status {
  Nickserv
  .Set NSAutoAuth:/setnspw
  .Delete NSAutoAuth for current nick:/delnspw
  .Delete NSAutoAuth for another nick:/delnspwfor $$?="What nickname to delete auto-auth for?"
  .Link another nick to this one:/ns link $$?="What nickname would you like to link to $me $+ ?"
}
menu nicklist {
  ChanServ
  .Check Access:/cs access $chan $$1
  .Give Access
  ..SOP
  ...Add:/cs sop $chan ADD $$1
  ...Del:/cs sop $chan del $$1
  ..AOP
  ...Add:/cs aop $chan add $$1
  ...Del:/cs aop $chan del $$1
  ..HOP
  ...Add:/cs hop $chan add $$1
  ...Del:/cs hop $chan del $$1
  ..VOP
  ...Add:/cs vop $chan add $$1
  ...Del:/cs vop $chan del $$1
  .-
  .Have Chanserv...
  ..Op $$1 in $chan:/cs op $chan $$1
  ..Deop $$1 in $chan:/cs deop $chan $$1
  ..Voice $$1 in $chan:/cs voice $chan $$1
  ..Devoice $$1 in $chan:/cs devoice $chan $$1

}
#opers off
menu nicklist {
  -
  Oper
  .Kill:/kill $$1 $$?="Why are you killing $$1 $+ ?"
  .Fake Kill:/fkill $$1 $$?="What reason is your fake kill of $$1 $+ ?"
  .OperServ
  ..Gline
  ...1 Hour Quick Block:/os block $$1
  ...1 Hour Quick Block with reason:/os block $$1 $$?="Why are you glining $$1 for 1 hour?"
  ..Op:/os op $chan $$1
  ..Deop:/os deop $chan $$1
  ..Voice:/os voice $chan $$1
  ..Devoice:/os devoice $chan $$1
} 

menu channel {
  OperServ
  .Op:/os op $chan $me
  .Deop:/os deop $chan $me
  .Voice:/os voice $chan $me
  .Devoice:/os devoice $chan $me

}
#opers end
