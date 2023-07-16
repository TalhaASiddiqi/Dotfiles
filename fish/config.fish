### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/Talha/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)


set --export OBJC_DISABLE_INITIALIZE_FORK_SAFETY "YES"

# The next line updates PATH for the Google Cloud SDK.
if test -e /Users/Talha/google-cloud-sdk/path.fish.inc 
  . /Users/Talha/google-cloud-sdk/path.fish.inc
end

# The next line enables shell command completion for gcloud.
if test -e /Users/Talha/google-cloud-sdk/completion.fish.inc 
  . /Users/Talha/google-cloud-sdk/completion.fish.inc
end

source ~/.iterm2_shell_integration.fish

load_nvm > /dev/stderr


set -g tide_right_prompt_items status cmd_duration context jobs direnv virtual_env rustc java php pulumi chruby go distrobox toolbox terraform aws nix_shell crystal elixir