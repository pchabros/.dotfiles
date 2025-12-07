let g:cornelis_use_global_binary = 1
let g:cornelis_split_location = 'bottom'
let g:cornelis_no_agda_input = 1
let g:cornelis_agda_prefix = "<Tab>"

call cornelis#bind_input("sa", "𝔸")
call cornelis#bind_input("sn", "ℕ")
call cornelis#bind_input("sn", "ℕ")
call cornelis#bind_input("si", "𝕀")
call cornelis#bind_input("sq", "ℚ")
call cornelis#bind_input("sz", "ℤ")
call cornelis#bind_input("s0", "∅")

call cornelis#bind_input("sub", "⊂")
call cornelis#bind_input("sub=", "⊆")
call cornelis#bind_input("in", "∈")

call cornelis#bind_input("qa", "∀")
call cornelis#bind_input("qe", "∃")
call cornelis#bind_input("qne", "∄")

call cornelis#bind_input("-->", "⟶")
call cornelis#bind_input("->", "→")
call cornelis#bind_input("=>", "⇒")
call cornelis#bind_input("::", "∷")
call cornelis#bind_input("==", "≡")
call cornelis#bind_input("/==", "≢")
call cornelis#bind_input(">=", "≥")
call cornelis#bind_input("neg", "¬")
call cornelis#bind_input("ne", "≠")
call cornelis#bind_input("nequiv", "≢")

call cornelis#bind_input("And", "⋀")
call cornelis#bind_input("Or", "⋁")
call cornelis#bind_input("and", "∧")
call cornelis#bind_input("or", "∨")

call cornelis#bind_input("sum", "∑")

au BufWritePost *.agda execute "normal! :CornelisLoad\<CR>"
