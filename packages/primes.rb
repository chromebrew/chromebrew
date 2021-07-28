require 'packages/libbsdgames2'

class Primes < Bsdgame
  description 'Primes generates prime numbers up to 2^64-1'
  homepage $_bsdgame_homepage
  version $_bsdgame_version
  license 'BSD'
  compatibility 'all'
  source_url $_bsdgame_source_url
  git_hashtag $_bsdgame_git_hashtag

  bsdgame 'primes'
end
