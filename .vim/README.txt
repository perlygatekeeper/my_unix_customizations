  cd ~/VIM\ stuff
  unzip vcscommand-1.99.46.zip
  cd ~/.vim
  cp       ~/VIM\ stuff/mileszs-ack.vim-9895285/plugin/ack.vim plugin/
  cp       ~/VIM\ stuff/mileszs-ack.vim-9895285/doc/ack.txt doc/

  cd ~/.vim
  tar zxvf /media/sf_Downloads/vimball.tar.gz
  unzip    ~/VIM\ stuff/surround.zip
  unzip    ~/VIM\ stuff/snipMate.zip
  unzip    ~/VIM\ stuff/matchit.zip
  unzip    ~/VIM\ stuff/NERD_tree.zip
  unzip    ~/VIM\ stuff/vcscommand-1.99.46.zip
  cp       ~/VIM\ stuff/a.vim			.
  cp       ~/VIM\ stuff/python_match.vim	.
  cp       ~/VIM\ stuff/repeat.vim		.

  vi command-t-1.3.vba :<- inside type :so % then :helptags ~/.vim/doc
