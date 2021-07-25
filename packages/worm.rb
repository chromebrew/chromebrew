require 'package'
require 'packages/libbsdgames2'

class Worm < Bsdgame
  description 'Eat numerical digits to grow longer. Don\'t run into yourself or the edge!'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'worm'
end
