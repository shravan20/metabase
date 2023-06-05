
upstream_branch=(gitconfigbranch.(git symbolic-ref -q HEAD).remote)/(gitconfigbranch.(git symbolic-ref -q HEAD).merge)
if [ -z "$upstream_branch" ]; then
echo "The current branch is not tracking an upstream branch."
exit 1
fi
# Check if the current commit is present in the upstream branch history
current_commit=$(git rev-parse HEAD)
upstream_commits=$(git log --oneline $upstream_branch | grep $current_commit)
if [ -z "$upstream_commits" ]; then
echo "The current commit is not present in the upstream branch history."
exit 1
fi


# Check if the current commit is the latest commit in the upstream branch
latest_upstream_commit=$(git rev-parse $upstream_branch@{u})
if [ $current_commit != $latest_upstream_commit ]; then
  echo "WARNING: The current commit is not the latest commit in the upstream branch."
fi
