setlocal foldmethod=indent
setlocal foldexpr=getPointFold(v:lnum)


function! GetPointFold(lnum)
  return IndentLevel(lnum)
endfunction

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction


