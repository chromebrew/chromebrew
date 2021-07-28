require 'packages/libbsdgames2'

class Robots < Bsdgame
  description 'Robots pits you against evil robots trying to kill you. Avoid them.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'robots'
end
