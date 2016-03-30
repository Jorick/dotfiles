# Script to update pure theme

update-pure(){
  current_path=`pwd`
  echo "Pulling latest Pure from Github."
  ( cd $HOME/github/pure/ && git pull origin master)
  echo "Next!"
  echo "Pulling latest zsh syntax highlighting from Github."
  ( cd $HOME/github/zsh-syntax-highlighting/ && git pull origin master )
  echo "Finished!"
  cd $current_path
}
