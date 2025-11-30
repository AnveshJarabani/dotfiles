# ============================================================
# TERMINAL COLORS CONFIGURATION
# ============================================================

# Vivid LS_COLORS - Makes ls output super colorful!
export LS_COLORS='rs=0:di=01;38;5;33:ln=01;38;5;51:mh=00:pi=40;38;5;11:so=01;38;5;13:do=01;38;5;5:bd=40;38;5;11;01:cd=40;38;5;3;01:or=40;38;5;9;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;38;5;46:*.tar=01;38;5;9:*.tgz=01;38;5;9:*.arc=01;38;5;9:*.arj=01;38;5;9:*.taz=01;38;5;9:*.lha=01;38;5;9:*.lz4=01;38;5;9:*.lzh=01;38;5;9:*.lzma=01;38;5;9:*.tlz=01;38;5;9:*.txz=01;38;5;9:*.tzo=01;38;5;9:*.t7z=01;38;5;9:*.zip=01;38;5;9:*.z=01;38;5;9:*.dz=01;38;5;9:*.gz=01;38;5;9:*.lrz=01;38;5;9:*.lz=01;38;5;9:*.lzo=01;38;5;9:*.xz=01;38;5;9:*.zst=01;38;5;9:*.tzst=01;38;5;9:*.bz2=01;38;5;9:*.bz=01;38;5;9:*.tbz=01;38;5;9:*.tbz2=01;38;5;9:*.tz=01;38;5;9:*.deb=01;38;5;9:*.rpm=01;38;5;9:*.jar=01;38;5;9:*.war=01;38;5;9:*.ear=01;38;5;9:*.sar=01;38;5;9:*.rar=01;38;5;9:*.alz=01;38;5;9:*.ace=01;38;5;9:*.zoo=01;38;5;9:*.cpio=01;38;5;9:*.7z=01;38;5;9:*.rz=01;38;5;9:*.cab=01;38;5;9:*.wim=01;38;5;9:*.swm=01;38;5;9:*.dwm=01;38;5;9:*.esd=01;38;5;9:*.avif=01;38;5;13:*.jpg=01;38;5;13:*.jpeg=01;38;5;13:*.mjpg=01;38;5;13:*.mjpeg=01;38;5;13:*.gif=01;38;5;13:*.bmp=01;38;5;13:*.pbm=01;38;5;13:*.pgm=01;38;5;13:*.ppm=01;38;5;13:*.tga=01;38;5;13:*.xbm=01;38;5;13:*.xpm=01;38;5;13:*.tif=01;38;5;13:*.tiff=01;38;5;13:*.png=01;38;5;13:*.svg=01;38;5;13:*.svgz=01;38;5;13:*.mng=01;38;5;13:*.pcx=01;38;5;13:*.mov=01;38;5;13:*.mpg=01;38;5;13:*.mpeg=01;38;5;13:*.m2v=01;38;5;13:*.mkv=01;38;5;13:*.webm=01;38;5;13:*.webp=01;38;5;13:*.ogm=01;38;5;13:*.mp4=01;38;5;13:*.m4v=01;38;5;13:*.mp4v=01;38;5;13:*.vob=01;38;5;13:*.qt=01;38;5;13:*.nuv=01;38;5;13:*.wmv=01;38;5;13:*.asf=01;38;5;13:*.rm=01;38;5;13:*.rmvb=01;38;5;13:*.flc=01;38;5;13:*.avi=01;38;5;13:*.fli=01;38;5;13:*.flv=01;38;5;13:*.gl=01;38;5;13:*.dl=01;38;5;13:*.xcf=01;38;5;13:*.xwd=01;38;5;13:*.yuv=01;38;5;13:*.cgm=01;38;5;13:*.emf=01;38;5;13:*.ogv=01;38;5;13:*.ogx=01;38;5;13:*.aac=00;38;5;45:*.au=00;38;5;45:*.flac=00;38;5;45:*.m4a=00;38;5;45:*.mid=00;38;5;45:*.midi=00;38;5;45:*.mka=00;38;5;45:*.mp3=00;38;5;45:*.mpc=00;38;5;45:*.ogg=00;38;5;45:*.ra=00;38;5;45:*.wav=00;38;5;45:*.oga=00;38;5;45:*.opus=00;38;5;45:*.spx=00;38;5;45:*.xspf=00;38;5;45:*~=00;38;5;8:*#=00;38;5;8:*.bak=00;38;5;8:*.old=00;38;5;8:*.orig=00;38;5;8:*.part=00;38;5;8:*.rej=00;38;5;8:*.swp=00;38;5;8:*.tmp=00;38;5;8:*.dpkg-dist=00;38;5;8:*.dpkg-old=00;38;5;8:*.ucf-dist=00;38;5;8:*.ucf-new=00;38;5;8:*.ucf-old=00;38;5;8:*.rpmnew=00;38;5;8:*.rpmorig=00;38;5;8:*.rpmsave=00;38;5;8:*.py=00;38;5;226:*.js=00;38;5;214:*.ts=00;38;5;39:*.json=00;38;5;178:*.yml=00;38;5;208:*.yaml=00;38;5;208:*.md=00;38;5;15:*.sh=00;38;5;46:*.log=00;38;5;240'

# Enhanced syntax highlighting colors for zsh-syntax-highlighting
ZSH_HIGHLIGHT_STYLES[default]='fg=white'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'

# Cool grep colors - highlights matches in bright colors
export GREP_COLORS='ms=01;38;5;202:mc=01;38;5;202:sl=:cx=:fn=38;5;141:ln=38;5;108:bn=38;5;108:se=38;5;240'

# Enable colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\e[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\e[1;35m'     # begin underline
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
