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
    aarch64: '95c8b6b79ed89ff9214d8fcd8aa29af940517e5a77e369f509bb2e56a7518cd8',
     armv7l: '95c8b6b79ed89ff9214d8fcd8aa29af940517e5a77e369f509bb2e56a7518cd8',
       i686: '3bf6fddf4da907b3aa4b6d93b993fc7717bbbefc5b468fe5dd1fc1809f8a1540',
     x86_64: 'f61c12d723d3353d685970bf07b1f10990fa589dfe013cd4a2c98cf6d0b79875'
  })

  depends_on 'glibc' # R

  run_tests
end
