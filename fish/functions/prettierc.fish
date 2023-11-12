function prettierc
    yarn prettier --write $(git diff --name-only --diff-filter d | grep -e '\.[tj]sx\?$')
end

