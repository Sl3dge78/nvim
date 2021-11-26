Tout mettre dans W:/\_vim  

### To store vim init files elsewhere add to the default vimrc
set runtimepath^=W:/_vim runtimepath+=W:/_vim/after
let &packpath = &runtimepath
source W:/_vim/.vimrc
