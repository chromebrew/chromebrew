require 'package'
require 'packages/libbsdgames2'

class Monop < Bsdgame
  description 'Monop is similar to the board game Monopoly. Monitors a game between 2 to 9 users. Rule knowledge is assumed.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  @_bsdgame = self.name.to_s.downcase
end
