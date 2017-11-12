
### Directory of zsh
export ZDOTDIR=$HOME/.dot/zsh

### Client name
client=("lab" "rino")

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi

#---------------------------------------------------------------------
# local setting
#---------------------------------------------------------------------
fz="zshenv"
for c in $client; do
    if [[ -s "${ZDOTDIR:-$HOME}/$c/$fz" ]]; then . ${ZDOTDIR:-$HOME}/$c/$fz ; fi
done
