require 'package'
require 'packages/libbsdgames2'

class Adventure < Bsdgame
  description 'Colossal Cave Adventure is a text adventure game, developed between 1975 and 1977 by Will Crowther and Don Woods for the PDP-10 mainframe.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'adventure'
end
