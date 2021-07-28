require 'packages/libbsdgames2'

class Arithmetic < Bsdgame
  description 'Arithmetic is a cli game that asks you to solve simple arithmetic problems.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'arithmetic'
end
