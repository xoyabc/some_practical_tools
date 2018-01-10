```
map <F5> ms:call AddAuthor()<cr>'s

function AddAuthor()

        let n=1

        while n < 5

                let line = getline(n)

                if line =~'^\s*\*\s*\S*Last\s*modified\s*:\s*\S*.*$'

                        call UpdateTitle()

                        return

                endif

                let n = n + 1

        endwhile

        call AddTitle()

endfunction

function UpdateTitle()

        normal m'

        execute '/* Last modified\s*:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'

        normal "

        normal mk

        execute '/* Filename\s*:/s@:.*$@\=": ".expand("%:t")@'

        execute "noh"

        normal 'k

        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None

endfunction

function AddTitle()

        call append(0,"#!/usr/bin/python")

        call append(1,"# -*- coding:utf-8 -*-")

        call append(2,"# **********************************************************")

        call append(3,"# * Author        : louxiaohui")

        call append(4,"# * Email         : 1031138448@qq.com")

        call append(5,"# * Last modified : ".strftime("%Y-%m-%d %H:%M"))

        call append(6,"# * Filename      : ".expand("%:t"))

        call append(7,"# * Description   : ")

        call append(8,"# * ********************************************************")

        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None

endfunction
```
