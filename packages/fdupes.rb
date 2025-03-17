require 'buildsystems/autotools'

class Fdupes < Autotools
  description 'Program for identifying or deleting duplicate files residing within specified directories.'
  homepage 'https://github.com/adrianlopezroche/fdupes'
  version '2.3.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/adrianlopezroche/fdupes.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '380ae7833a60f5c8a3b5d6775e28247cfad53936b86d7d94c4cf62a12a71d0ff',
     armv7l: '380ae7833a60f5c8a3b5d6775e28247cfad53936b86d7d94c4cf62a12a71d0ff',
       i686: 'c1723549021cfecdf9cf087a81e5c5c1a3e307754d781932411d504422625409',
     x86_64: '73038847795557bb79c7ce94a38246816a7619d19e130ea3854151479a4923d6'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'pcre2' # R
  depends_on 'sqlite' # R

  run_tests
end
