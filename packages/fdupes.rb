require 'buildsystems/autotools'

class Fdupes < Autotools
  description 'Program for identifying or deleting duplicate files residing within specified directories.'
  homepage 'https://github.com/adrianlopezroche/fdupes'
  version '2.4.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/adrianlopezroche/fdupes.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43c75d3d38928f9103d80549d77c10d98c05ce79569916cb3dee751776afc653',
     armv7l: '43c75d3d38928f9103d80549d77c10d98c05ce79569916cb3dee751776afc653',
       i686: '4b33d978fafe38a107bcb3eb8aa1b2d4344c45c8c084d0c90ca6c8de04f5630b',
     x86_64: 'dafadea4932a9652e933a15505fad9ba82ab1bcbc48a04ae02503e938d33391d'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'pcre2' # R
  depends_on 'sqlite' # R

  run_tests
end
