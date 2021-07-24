require 'package'
require 'packages/libbsdgames2'

class Boggle < Bsdgame
  description 'A cli version of Boggle inspired by the Boggle Hasbro game.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  @_bsdgame = self.name.to_s.downcase
end
