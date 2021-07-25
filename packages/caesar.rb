require 'package'
require 'packages/libbsdgames2'

class Caesar < Bsdgame
  description 'Caesar performs rotated-alphabet cryptography, aka caesar cyphers.'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'caesar'
end
