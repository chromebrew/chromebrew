require 'package'
require 'packages/libbsdgames2'

class Cribbage < Bsdgame
  description 'Text-based cribbage card game.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  @_bsdgame = self.name.to_s.downcase
end
