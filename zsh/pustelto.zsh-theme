PROMPT='
%F{cyan}%B%n@%m:%F{white}%~ $(git_prompt_info)%b%F{008}$(package_version)
%B%f$(return_code)%f%b '

RPROMPT=''

PROMPT_SYMBOL=[%*]%B$'\u00BB'%b

function git_prompt_info() {
  WORKDIR_DIRTY=false
  local ref=$(git symbolic-ref HEAD 2> /dev/null)

  [[ -z "${ref}" ]] && return

  git_branch_info
  vcs_info
  local vcs_prompt="${vcs_info_msg_0_}"

  if [[ -n "$vcs_prompt" ]]; then
    if [[ "$WORKDIR_DIRTY" == true ]]; then
      # $vcs_visual_identifier gets set in +vi-vcs-detect-changes in functions/vcs.zsh,
      # as we have there access to vcs_info internal hooks.
      current_state='red'
    else
      current_state='green'
    fi
    echo "%F{$current_state}$THEME_GIT_PROMPT_PREFIX$vcs_prompt$THEME_GIT_PROMPT_SUFFIX%f "
  fi
}

THEME_GIT_PROMPT_PREFIX="["
THEME_GIT_PROMPT_SUFFIX="]$reset_color"

# Get additional informations from git via vcs module
function git_branch_info() {
  WORKDIR_DIRTY=false

  autoload -Uz vcs_info

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes true

  VCS_DEFAULT_FORMAT="%b%c%m"
  zstyle ':vcs_info:*' formats "$VCS_DEFAULT_FORMAT"

  zstyle ':vcs_info:*' actionformats "%b | %a | %c%m"

  zstyle ':vcs_info:*' stagedstr " $(echo '^')"
  # unstages files are hinted by red color of git info, additional mark is
  # unnecessary.
  # zstyle ':vcs_info:*' unstagedstr " $(echo '*')"

  HOOKS=(vcs-detect-changes git-aheadbehind git-untracked)
  zstyle ':vcs_info:git*+set-message:*' hooks $HOOKS
}

# Get number of commits branch is ahead or behind from upstream
# Taken from https://github.com/bhilburn/powerlevel9k
function +vi-git-aheadbehind() {
    local ahead behind branch_name
    local -a gitstatus

    branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)

    ahead=$(git rev-list "${branch_name}"@{upstream}..HEAD 2>/dev/null | wc -l)
    (( ahead )) && gitstatus+=( " \u2191${ahead// /}" )

    behind=$(git rev-list HEAD.."${branch_name}"@{upstream} 2>/dev/null | wc -l)
    (( behind )) && gitstatus+=( " \u2193${behind// /}" )

    hook_com[misc]+=${(j::)gitstatus}
}

function +vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
    # This will show the marker if there are any untracked files in repo.
    # If instead you want to show the marker only if there are untracked
    # files in $PWD, use:
    #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
    hook_com[staged]+=' *'
  fi
}

function +vi-vcs-detect-changes() {
  if [[ -n "${hook_com[staged]}" ]] || [[ -n "${hook_com[unstaged]}" ]]; then
    WORKDIR_DIRTY=true
  else
    WORKDIR_DIRTY=false
  fi
}

# Set color of prompt to red on non-0 return code
function return_code() {
  retval=$?
  if [ $retval -ne 0 ]; then
    echo "%F{red}$PROMPT_SYMBOL"
  else
    echo "%F{cyan}$PROMPT_SYMBOL"
  fi
}

# Displays name and version of current package.json file
function package_version() {
  local ref=$(cat package.json 2> /dev/null)
  [[ -z "${ref}" ]] && return

  local name=$(cat package.json | grep "name" | head -1 | awk -F: '{ print $2 }' | sed 's/[ ",]//g')
  local ver=$(cat package.json | grep "version" | head -1 | awk -F: '{ print $2}' | sed 's/[ ",]//g')
  echo $name@$ver
}
