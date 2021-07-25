require 'package'
require 'packages/libbsdgames2'

class Tetris < Bsdgame
  description 'A TUI game inspired by EA\'s 1984 Tetris.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'tetris'
end
