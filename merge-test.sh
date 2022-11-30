set -e


shopt -s extglob
shopt -s dotglob

OLD_REPOS=(polisServer polisMath polisClientAdmin polisClientParticipation polisReport)
NEW_DIRS=( server      math      client-admin     client-participation     report)
MONOREPO="polis"

echo "Removing old poly repos."
rm -rf $all_repos
rm -rf monorepo

for r in ${OLD_REPOS[@]}; do
  echo "--- Cloning poly/$r..."
  git clone --quiet https://github.com/montana/poly*
done

echo "--- Cloning monorepo..."
git clone --quiet https://github.com/montana/mono*/${MONOREPO}

for (( index=0; index<${#OLD_REPOS[*]}; ++index)); do
	echo "diff -r -q ${OLD_REPOS[$index]} polis/${NEW_DIRS[$index]} "
	diff -r -q ${OLD_REPOS[$index]} polis/${NEW_DIRS[$index]} \
		&& echo ""	
done

exit 0
