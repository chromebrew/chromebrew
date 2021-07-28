require 'packages/libbsdgames2'

class Pom < Bsdgame
  description 'Pom displays the current phase of the moon.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'pom'
end
