require 'packages/libbsdgames2'

# I'd really like this package name to be "random", however classes don't seem to be able to be named "random".
class Randomlines < Bsdgame
  description 'Random reads lines from stdin and randomly copies some to stdout.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'random'
end
