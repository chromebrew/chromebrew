require 'package'
require 'packages/libbsdgames2'

class Millie < Bsdgame
  description 'Mille is a two-handed game inspired by the Parker Brother\'s game of Mille Bornes.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  @_bsdgame = self.name.to_s.downcase
end
