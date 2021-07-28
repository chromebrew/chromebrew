require 'packages/libbsdgames2'

class Morse < Bsdgame
  description 'Morse reformats input as morse code.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'morse'
end
