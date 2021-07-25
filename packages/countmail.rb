require 'package'
require 'packages/libbsdgames2'

class Countmail < Bsdgame
  description 'Informs the user of their loneliness or lack of friends. Perfect for a pandemic.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'countmail'
end
