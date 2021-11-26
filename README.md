### To store vim init files elsewhere 
- Add to the default vimrc :
```
set runtimepath^=W:/_vim runtimepath+=W:/_vim/after  
let &packpath = &runtimepath  
source W:/_vim/.vimrc  
```

Then clone this where you want (here in W:/\_vim)
 
