alias leftcolon {
  if ($left($1-,1) == :) {
    return $right($1-,-1)
  }
  else {
    return $1-
  }
}
alias rightcolon {
  if ($right,$1-,1) == :) {
    return $mid($1-,1,$calc($len($1)-1))
  }
  else {
    return $1-
  }
}
alias umode {
  mode $me $$1-
}
alias op {
  if (# isin $1) {
    mode $1 +o $2
    mode $1 +o $$3
    mode $1 +o $$4
    mode $1 +o $$5
    mode $1 +o $$6
    mode $1 +o $$7
    mode $1 +o $$8
    mode $1 +o $$9
    mode $1 +o $$10
    mode $1 +o $$11
  }
  else {
    mode $chan +o $$1
    mode $chan +o $$2
    mode $chan +o $$3
    mode $chan +o $$4
    mode $chan +o $$5
    mode $chan +o $$6
    mode $chan +o $$7
    mode $chan +o $$8
    mode $chan +o $$9
    mode $chan +o $$10
  }
}
alias deop {
  if (# isin $1) {
    mode $1 -o $2
    mode $1 -o $$3
    mode $1 -o $$4
    mode $1 -o $$5
    mode $1 -o $$6
    mode $1 -o $$7
    mode $1 -o $$8
    mode $1 -o $$9
    mode $1 -o $$10
    mode $1 -o $$11
  }
  else {
    mode $chan -o $$1
    mode $chan -o $$2
    mode $chan -o $$3
    mode $chan -o $$4
    mode $chan -o $$5
    mode $chan -o $$6
    mode $chan -o $$7
    mode $chan -o $$8
    mode $chan -o $$9
    mode $chan -o $$10
  }
}
alias voice {
  if (# isin $1) {
    mode $1 +v $$2
    mode $1 +v $$3
    mode $1 +v $$4
    mode $1 +v $$5
    mode $1 +v $$6
    mode $1 +v $$7
    mode $1 +v $$8
    mode $1 +v $$9
    mode $1 +v $$10
    mode $1 +v $$11
  }
  else {
    mode $chan +v $$1
    mode $chan +v $$2
    mode $chan +v $$3
    mode $chan +v $$4
    mode $chan +v $$5
    mode $chan +v $$6
    mode $chan +v $$7
    mode $chan +v $$8
    mode $chan +v $$9
    mode $chan +v $$10
  }
}
alias devoice {
  if (# isin $1) {
    mode $1 -v $$2
    mode $1 -v $$3
    mode $1 -v $$4
    mode $1 -v $$5
    mode $1 -v $$6
    mode $1 -v $$7
    mode $1 -v $$8
    mode $1 -v $$9
    mode $1 -v $$10
    mode $1 -v $$11
  }
  else {
    mode $chan -v $$1
    mode $chan -v $$2
    mode $chan -v $$3
    mode $chan -v $$4
    mode $chan -v $$5
    mode $chan -v $$6
    mode $chan -v $$7
    mode $chan -v $$8
    mode $chan -v $$9
    mode $chan -v $$10
  }
}
