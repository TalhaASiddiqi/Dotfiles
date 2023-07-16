function bnames
  grep refs/heads | tr -d '.' | cut -d'/' -f3 | awk '{ printf "%s", $0" " }'
end