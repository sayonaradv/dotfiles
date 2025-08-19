fn ls {|@a| e:ls -l --color $@a }
fn lsa {|@a| e:ls -la --color $@a }
fn lsas {|@a| e:ls -la -S --color $@a }
fn lg {|@a| e:lazygit $@a }
fn v {|@a| e:nvim $@a }

eval (starship init elvish)
eval (zoxide init elvish | slurp)
