if exists("g:loaded_syntastic_notifier_autoloclist") || !exists("g:loaded_syntastic_plugin")
    finish
endif
let g:loaded_syntastic_notifier_autoloclist = 1

let g:SyntasticAutoloclistNotifier = {}

" Public methods {{{1
"
function! g:SyntasticAutoloclistNotifier.New() " {{{2
    let newObj = copy(self)
    return newObj
endfunction " }}}2

function! g:SyntasticAutoloclistNotifier.refresh(loclist) " {{{2
    call syntastic#log#debug(g:SyntasticDebugNotifications, 'autoloclist: refresh')
    call g:SyntasticAutoloclistNotifier.AutoToggle(a:loclist)
endfunction " }}}2

function! g:SyntasticAutoloclistNotifier.AutoToggle(loclist) " {{{2
    call syntastic#log#debug(g:SyntasticDebugNotifications, 'autoloclist: toggle')
    if !a:loclist.isEmpty()
        if syntastic#util#var('auto_loc_list') == 1
            if a:loclist.getState()
                call a:loclist.show()
            else
                lclose
            endif
        endif
    else
        if syntastic#util#var('auto_loc_list') > 0
            call a:loclist.setState(0)

            "TODO: this will close the loc list window if one was opened by
            "something other than syntastic
            lclose
        endif
    endif
endfunction " }}}2

" }}}1

" vim: set sw=4 sts=4 et fdm=marker:
