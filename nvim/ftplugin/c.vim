"number of visual spaces per TAB
set tabstop=4
"number of space in tab when editing
set softtabstop=4
"tabs are spaces
set expandtab

set shiftwidth=4

set autoindent
set cindent
"set textwidth=79

set foldmethod=syntax
set nofoldenable



function s:showResults(msg) 
  let bufName = "__Build_msg__"
     execute "split " . bufName 
    if bufwinnr(bufName) > 0
      echo "buf open"
    else
      return
       normal! ggdG
       "setlocal filetype=potionbytecode
       setlocal buftype=nofile
       "insert to file
       call append(0, split(a:msg, '\v\n'))
    endif
  
endfunction

function BuildSimple(show) 
  let dir =  getcwd() 
  let buildScript = dir . "/build.sh"

  if (a:show)
    execute  ":belowright 10split term://" . buildScript 
    let running = jobwait([&channel], 0)[0] == -1
    let id = b:terminal_job_id
    "call jobsend(id, buildScript)
  else
    call system(buildScript)
  endif
  return v:shell_error

endfunction


function RunSimple() 
  let dir =  getcwd() 
  let bin = dir . "/build/" . expand("%:t:r") 
  call BuildSimple(0)
  execute  ":belowright 10split term://" . bin 

endfunction

nnoremap <leader>b :call BuildSimple(1) <CR>
nnoremap <leader>r :call RunSimple() <CR>
