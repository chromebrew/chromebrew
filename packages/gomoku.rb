require 'packages/libbsdgames2'

class Gomoku < Bsdgame
  description 'A Connect-5 version of tic-tac-toe.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'gomoku'
end
