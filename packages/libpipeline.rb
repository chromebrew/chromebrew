require 'buildsystems/autotools'

class Libpipeline < Autotools
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'
  version '1.5.8'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/libpipeline/libpipeline.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f768c69ef121e147263284152f30133e7449699aeb5754ed68059d67672c15f',
     armv7l: '0f768c69ef121e147263284152f30133e7449699aeb5754ed68059d67672c15f',
       i686: '3bf6fddf4da907b3aa4b6d93b993fc7717bbbefc5b468fe5dd1fc1809f8a1540',
     x86_64: 'f61c12d723d3353d685970bf07b1f10990fa589dfe013cd4a2c98cf6d0b79875'
  })

  depends_on 'glibc' # R

  run_tests
end
