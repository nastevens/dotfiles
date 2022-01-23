; Give Rust doccomments a little flair
((line_comment) @text
  (#lua-match? @text "^//[!/]+.*$"))

; Fix `use` not being colored as a keyword
(use_declaration "use" @keyword)
