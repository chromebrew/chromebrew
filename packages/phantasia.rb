require 'package'
require 'packages/libbsdgames2'

class Phantasia < Bsdgame
  description 'Phantasia is a multi-player multi-terminal fantasy game.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'phantasia'
end
