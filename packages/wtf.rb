require 'package'
require 'packages/libbsdgames2'

class Wtf < Bsdgame
  description 'Look up abbreviations to find out wtf they stand for.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'wtf'
end
