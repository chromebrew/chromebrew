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
       i686: 'f48dc0e7fa58b857de93c586c7eb80b473f1fb4b1ee617eec60304f76c280d22',
     x86_64: 'bcdc10711b7697fd61d50f996a5df4467702914d36823d7fbc62590b1f0a5ece'
  })

  depends_on 'glibc' # R

  run_tests
end
