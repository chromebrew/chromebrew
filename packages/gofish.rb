require 'package'
require 'packages/libbsdgames2'

class Gofish < Bsdgame
  description 'Text-based go fish card game.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  @_bsdgame = 'fish' # Not to be confused with the shell fish
end
