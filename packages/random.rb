require 'package'
require 'packages/libbsdgames2'

class Random < Bsdgame
  description 'Random reads lines from stdin and randomly copies some to stdout.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  @_bsdgame = self.name.to_s.downcase
end
