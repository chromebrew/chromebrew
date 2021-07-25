require 'package'
require 'packages/libbsdgames2'

class Hangman < Bsdgame
  description 'Guess the word before it\'s too late.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'hangman'

  depends_on 'words'
end
