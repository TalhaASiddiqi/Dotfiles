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

# fish_config theme save "Catppuccin Mocha"
load_nvm > /dev/stderr
fish_add_path --path /opt/homebrew/bin 
fish_add_path --path /opt/homebrew/opt/openjdk/bin

set --export CPPFLAGS -I/opt/homebrew/opt/openjdk/include
set --export JAVA_HOME /opt/homebrew/opt/openjdk

zoxide init fish | source
