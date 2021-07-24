require 'package'
require 'packages/libbsdgames2'

class Backgammon < Bsdgame
  description 'A text-based backgammon game; play against the computer or a friend.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  @_bsdgame = self.name.to_s.downcase
end
