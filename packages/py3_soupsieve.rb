require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80a1bec46ca019b5ff902b766541ab2f77b80ba9dfb23e70e20d6de5250b52a6',
     armv7l: '80a1bec46ca019b5ff902b766541ab2f77b80ba9dfb23e70e20d6de5250b52a6',
       i686: '559402b6e2065be634d218591ef7ce12e0354c8b1de4d995e5a37a16afbe1d29',
     x86_64: 'a8f2d91c48b2088d0036d8d781c949588c67a2f03055d08f60c9501154805611'
  })

  depends_on 'python3' => :logical

  no_source_build
end
