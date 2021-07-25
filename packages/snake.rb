require 'package'
require 'packages/libbsdgames2'

class Snake < Bsdgame
  description 'Don\'t get eaten by the snake.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'snake'
end
