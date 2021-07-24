require 'package'
require 'packages/libbsdgames2'

class Bsdgames < Package
  description 'A metapackage of classic text mode games from UNIX folklore.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  compatibility 'all'
  is_fake

  depends_on 'adventure'
  depends_on 'arithmetic'
  depends_on 'atc'
  depends_on 'battlestar'
  depends_on 'bcd'
  depends_on 'boggle'
  depends_on 'caesar'
  depends_on 'canfield'
  depends_on 'countmail'
  depends_on 'cribbage'
  # Dm excluded as it doesn't make sense in the context of Chromebrew or modern Linux
  depends_on 'gofish'
  depends_on 'gomoku'
  depends_on 'hangman'
  depends_on 'hunt'
  depends_on 'mille'
  depends_on 'monopoly'
  depends_on 'morse'
  depends_on 'number'
  depends_on 'phantasia'
  depends_on 'pig'
  depends_on 'pom'
  depends_on 'ppt'
  depends_on 'primes'
  depends_on 'quiz'
  depends_on 'rain'
  depends_on 'randomlines'
  depends_on 'robots'
  depends_on 'snail'
  depends_on 'snake'
  depends_on 'tetris'
  depends_on 'trek'
  depends_on 'wargames'
  depends_on 'worm'
  depends_on 'worms'
  depends_on 'wtf'

end
