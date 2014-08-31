;--------------------------------------------
; irc2html [2004.04.18] by Andy Dufilie
;--------------------------------------------
; Website: http://pages.cthome.net/pdufilie/
;--------------------------------------------


; Change this alias if you want output files to go to a different directory or have different filenames.
alias -l modify_output_filename {
  var %directory = $nofile($1-)
  var %file = $nopath($1-)

  ; replace invalid characters
  %file = $mkfn(%file)

  ; remove "#"
  %file = $remove(%file,$chr(35))

  ; make sure there's a character before the "."
  if (.* iswm %file) %file = _ $+ %file

  ; replace char 160 (non-breaking space)
  %file = $replace(%file,$chr(160),_)

  return %directory $+ %file
}


; buffer conversion
; /buf2html [window]
alias buf2html {
  reset
  if ($window($1-)) var %@ = $1-
  else var %@ = $active
  %i2h.buffermode = 1
  if (%@ == status window) filter -swz @i2h
  elseif (=* iswm %@) {
    %i2h.buffermode = 0
    savebuf %@ irc2html.tmp
    loadbuf @i2h irc2html.tmp
    .remove irc2html.tmp
  }
  else filter -wwz %@ @i2h
  var %x = $line(@i2h,0)
  while (%x) {
    if ($line(@i2h,%x) == $chr(32)) dline @i2h %x
    dec %x
  }
  var %t = %@ buffer
  var %f = $mkfn(%@) $+ .html
  var %outputfile = $i2h(%t,%f)
  echo $colour(i) -q *** Done making %outputfile
  ;run $shortfn(%outputfile)
}

; file conversion
; /log2html [file]
alias log2html {
  var %dll = 0
  if ($1 == -dll) {
    %dll = 1
    tokenize 32 $2-
  }
  elseif ($1 == -mrc) {
    %dll = 0
    tokenize 32 $2-
  }

  if ($isfile($1-)) var %log = $1-
  elseif ($version < 5.8) var %log = $dir="Pick a .log" $shortfn($logdir*.log)
  else var %log = $sfile($logdir*.log,Pick a .log)
  if ($isfile(%log) == $false) {
    if (%log) echo $colour(info) * /log2html: File doesn't exist: %log
    return
  }
  if (*.log iswm %log) var %html = $left(%log,-3) $+ html
  else var %html = %log $+ .html

  if (%dll) {
    var %irc2html.dll = $findfile($scriptdir,irc2html.dll,1)
    if ($isfile(%irc2html.dll) != $true) { 
      %irc2html.dll = $findfile($mircdir,irc2html.dll,1)
      if ($isfile(%irc2html.dll) != $true) {
        echo $colour(i) *** irc2html.dll is missing.
        return
      }
    }

    ;filename $+ $cr $+ outfile?fontname?defaultfore?defaultback?rgb0?rgb1?rgb2?rgb3?rgb4?rgb5?rgb6?rgb7?rgb8?rgb9?rgb10?rgb11?rgb12?rgb13?rgb14?rgb15

    var %size = $window(@i2h).fontsize
    if (%size < 0) %size = $right(%size,-1) $+ pt
    else %size = %size $+ px

    window -h @irc2html
    var %n = 0, %params = %log $+ $cr $+ %html $+ ? $+ $window(@i2h).font $+ ;font-size: $+ %size $+ ? $+ $colour(normal) $+ ? $+ $colour(background)
    close -@ @irc2html
    while (%n < 16) {
      %params = %params $+ ? $+ $colour(%n)
      inc %n
    }
    var %outputfile = $dll(%irc2html.dll,irc2html,%params)
  }
  else {
    reset
    loadbuf @i2h $shortfn(%log)
    var %title = $nopath(%log)
    if (*.log iswm %title) %title = $left(%title,-4) log
    var %outputfile = $i2h(%title,%html)
    echo $colour(i) -q *** Done making %outputfile
  }

  ;run $shortfn(%outputfile)
}

; clipboard conversion
; /cb2html
alias cb2html {
  reset
  var %x = 1, %f = clipboard.html
  while (%x <= $cb(0)) {
    aline @i2h $iif(* iswm $cb(%x),$cb(%x),)
    inc %x
  }
  var %outputfile = $i2h(Clipboard,%f)
  echo $colour(i) -q *** Done making %outputfile
  ;run %outputfile
}

; single line conversion (output to window)
; /irc2html <text>
alias irc2html {
  if (* !iswm $1-) return
  if (* !iswm $window(@irc2html)) reset
  close -@ @i2h
  window -h @i2h
  aline @i2h $1-
  window -h @irc2html
  var %x = $line(@irc2html,0)
  if (</html> isin $line(@irc2html,%x)) dline @irc2html %x
  i2h
  window -aw @irc2html
}

on *:close:@irc2html:unset %i2h.*
alias -l reset {
  close -@ @i2h @irc2html
  unset %i2h.*
  window -h @i2h
}
alias -l _rgb {
  tokenize 44 $rgb($colour($1))
  return $base($1,10,16,2) $+ $base($2,10,16,2) $+ $base($3,10,16,2)
}
; $i2h(title,outfile) returns output file w/ quotes
; /i2h with no parameters is used for /irc2html single-line conversion
alias -l i2h {
  var %title = $1
  var %outputfile = $modify_output_filename($2)
  window -h @irc2html
  var %ctime = $ctime, %x = 16
  while (%x) {
    dec %x
    %i2h. [ $+ [ %x ] ] = $_rgb(%x)
  }
  if (* iswm %outputfile) || ($line(@irc2html,0) !isnum 1-) {
    if (* iswm %outputfile) aline @irc2html <html><head><title> $+ %title $+ </title><style type="text/css"><!--
    else aline @irc2html <html><head><title>irc2html</title><style type="text/css"><!--
    var %size = $window(@i2h).fontsize
    if (%size < 0) %size = $right(%size,-1) $+ pt
    else %size = %size $+ px
    aline @irc2html body{font-family: $+ $window(@i2h).font $+ ;font-size: $+ %size $+ ;color: $+ %i2h. [ $+ [ $colour(no) ] ] $+ ;background-color: $+ %i2h. [ $+ [ $colour(b) ] ] $+ ;}
    aline @irc2html --></style></head><body>
  }
  %x = $line(@i2h,0)
  while (%x) {
    %i2h.ecolor = $line(@i2h,1).color
    convert $line(@i2h,1)
    dline @i2h 1
    editbox -a %x
    dec %x
  }
  editbox -a
  if (* iswm %outputfile) {
    aline @irc2html </body></html><!-- $duration($calc($ctime -%ctime)) -->
    unset %i2h.*
    savebuf @irc2html " $+ %outputfile $+ "
    close -@ @irc2html
  }
  else aline @irc2html </body></html>
  close -@ @i2h
  return %outputfile
}
alias -l classname {
  var %bold = $1, %underline = $2, %fcolor = $3, %bcolor = $4, %reverse = $5, %bg = $6
  var %class = $iif(%underline,$iif(%bold,W,X),$iif(%bold,Y,Z))
  if (%reverse != 1) {
    if (%class == Z) %class =
    %class = %class $+ $chr($calc($asc(A) + %fcolor))
    if (%bcolor != %bg) %class = %class $+ $chr($calc($asc(A) + %bcolor))
  }
  return %class
}
alias -l classdef {
  var %class = $1, %bold = $2, %underline = $3, %fcolor = $4, %bcolor = $5, %reverse = $6, %ncolor = $7, %bg = $8
  var %def = . $+ %class $+ {font-weight: $+ $iif(%bold,bold,normal)
  %def = %def $+ ;text-decoration: $+ $iif(%underline,underline,none)
  %def = %def $+ ;color: $+ %i2h. [ $+ [ $iif(%reverse,%bg,%fcolor) ] ]
  %def = %def $+ ;background-color: $+ %i2h. [ $+ [ $iif(%reverse,%ncolor,%bcolor) ] ]
  %def = %def $+ ;}
  return %def
}
; convert one line of text
alias -l convert {
  if (* !iswm $1-) return
  var %nbsp = $chr(160), %b = , %r = , %u = , %k = , %o = , %text = $replace($1-,&,&amp;,<,&lt;,>,&gt;) $+ %o, %ncolor = $colour(no), %ecolor = %ncolor, %bg = $colour(b), %etag = 0
  if ($version >= 6.14) && (%i2h.buffermode) %ecolor = %i2h.ecolor
  elseif ($1 == *) {
    if (/*: iswm $2) || ($2-3 == Invalid format:) || ($2-4 == Too many parameters:) || ($2-3 == Invalid parameters:) %ecolor = $colour(i)
    elseif (Break: iswm $2) %ecolor = $colour(c)
    else %ecolor = $colour(a)
  }
  elseif (-?*- iswm $1) var %ecolor = $colour(not)
  elseif (-> [*] iswm $1-2) var %ecolor = $colour(c)
  elseif ($1 == ***) var %ecolor = $colour(i)
  if (%ecolor !isnum) %ecolor = %ncolor
  if (%ecolor != %ncolor) %etag = 1
  var %btext = $replace(%text,%k,%b,%r,%b,%u,%b,%o,%b), %codenum = 1, %numcodes = $count(%btext,%b), %nextcodepos, %codepos = 1, %prevcodepos, %nocomma, %class, %baseclass, %prevclass
  var %char, %bold = 0, %underline = 0, %reverse = 0, %fcolor = %ecolor, %bcolor = %bg, %aline, %length = $len(%text), %tcolor, %inside_span = 0
  %baseclass = $classname(%bold,%underline,%ecolor,%bcolor,%reverse,%bg)
  %class = %baseclass
  if (%etag) {
    %aline = <span class= $+ %class $+ >
    ; define class if not already defined
    if (%i2h.c [ $+ [ %class ] ] != 1) {
      iline @irc2html 2 $classdef(%class,%bold,%underline,%fcolor,%bcolor,%reverse,%ncolor,%bg)
      %i2h.c [ $+ [ %class ] ] = 1
    }
  }
  while (%codenum <= %numcodes) {
    %prevcodepos = %codepos
    %nextcodepos = $pos(%btext,%b,%codenum)
    %codepos = %nextcodepos

    ; read control codes
    while ($mid(%btext,%codepos,1) == %b) {
      inc %codenum
      %char = $mid(%text,%codepos,1)
      if (%char == %k) {
        inc %codepos
        %nocomma = 1
        %tcolor =
        while ($mid(%text,%codepos,1) isnum) {
          %tcolor = $ifmatch
          inc %codepos
          if ($mid(%text,%codepos,1) isnum) {
            %tcolor = %tcolor $+ $ifmatch
            inc %codepos
          }
          if (%tcolor == 99) %tcolor = %ecolor
          if (%fcolor == 99) %fcolor = %bcolor
          %tcolor = $calc(%tcolor % 16)
          %fcolor = $calc(%fcolor % 16)
          if (%nocomma) %fcolor = %tcolor
          else %bcolor = %tcolor
          if (%nocomma) && ($mid(%text,%codepos,1) == ,) {
            %nocomma = 0
            inc %codepos
          }
          else break
        }
        if (* !iswm %tcolor) {
          %fcolor = %ecolor
          %bcolor = %bg
        }
      }
      else {
        if (%char == %b) %bold = 1 - %bold
        elseif (%char == %u) %underline = 1 - %underline
        elseif (%char == %r) %reverse = 1 - %reverse
        elseif (%char == %o) {
          %fcolor = %ecolor
          %bcolor = %bg
          %bold = 0
          %underline = 0
          %reverse = 0
        }
        inc %codepos
      }
    }
    ; done reading control codes

    %prevclass = %class
    %class = $classname(%bold,%underline,%fcolor,%bcolor,%reverse,%bg)

    ; append text since last control code
    if (%prevcodepos < %nextcodepos) {
      var %" = " $+ $mid(%text,%prevcodepos,$calc(%nextcodepos -%prevcodepos)) $+ "
      if (" * " iswm %") %aline = %aline $+ %nbsp $+ $right($left(%",-2),-2) $+ %nbsp
      elseif (" * iswm %") %aline = %aline $+ %nbsp $+ $right($left(%",-1),-2)
      elseif (* " iswm %") %aline = %aline $+ $right($left(%",-2),-1) $+ %nbsp
      else %aline = %aline $+ $right($left(%",-1),-1)
    }

    ; break out of loop if this the end of the line
    if (%codepos > %length) break

    ; check if span class needs changing
    if (%class != %prevclass) {
      ; close off previous tag if needed
      if (%inside_span) {
        %aline = %aline $+ </span>
        %inside_span = 0
      }
      ; begin new tag if needed
      if (%class != %baseclass) {
        ; define class if not already defined
        if (%i2h.c [ $+ [ %class ] ] != 1) {
          iline @irc2html 2 $classdef(%class,%bold,%underline,%fcolor,%bcolor,%reverse,%ncolor,%bg)
          %i2h.c [ $+ [ %class ] ] = 1
        }
        ; output text & new span tag
        aline @irc2html %aline $+ <span
        %aline = class= $+ %class $+ >
        ; remember that we're inside a span tag
        %inside_span = 1
      }
    }
  }

  ; close previous span tag if needed
  if (%inside_span) {
    %aline = %aline $+ </span>
    %inside_span = 0
  }
  ; add remaining text if needed
  if (%codepos <= %length) %aline $+ $mid(%text,%codepos)
  ; close outer span tag if needed
  if (%etag) %aline = %aline $+ </span>
  ; output with line break
  aline @irc2html %aline $+ <br>
}
