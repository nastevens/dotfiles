PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[red]%}%D{[%I:%M:%S]} %{$fg[cyan]%}%3~ %{$fg[blue]%}%(1j:(%j %(2j:jobs:job)%) :)$(git_prompt_info)\
%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}] %{$fg_bold[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}] %{$fg[green]%}✓"
