function g
  switch $argv[1]
    case "mm"
      git fetch origin master:master
      git merge master -m "Merge master"

      # push to master if flag is present
      if test (count $argv) -eq 3
        if test $argv[2] = "-p"
          git push origin master
        end
      end
    case "pull"
      git pull origin $(git symbolic-ref --short HEAD)
    case "pc"
      git push --set-upstream origin (git symbolic-ref --short HEAD)
    case "wt"
      set branch_name $argv[2]
      set dir_name $branch_name
      git worktree add -b $branch_name ../$dir_name $branch_name
    case "co"
      # checkout to branch
      set branch_name $argv[2]
      git checkout $branch_name
    case "ro"
      #reset current branch to origin
      git reset --hard origin/$(git symbolic-ref --short HEAD)
    case "*"
      echo "Invalid argument. Usage: g [mm|pc|wt|co]"
  end
end
