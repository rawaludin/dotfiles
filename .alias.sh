# ----------------------------
# My ALias
# ----------------------------

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update'

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Laravel
alias art="php artisan"
alias serve="php -S localhost:8000 -t public"
alias e="nvim"
alias tc="./vendor/bin/phpunit"
alias t="./vendor/bin/phpunit --no-coverage"
alias ts="./vendor/bin/phpunit --no-coverage --stop-on-error --stop-on-fail"
alias ctags="`brew --prefix`/bin/ctags"
alias stree='/Applications/SourceTree.app/Contents/Resources/stree' 
