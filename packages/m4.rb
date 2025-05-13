require 'buildsystems/autotools'

class M4 < Autotools
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.20'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/m4/m4-#{version}.tar.xz"
  source_sha256 'e236ea3a1ccf5f6c270b1c4bb60726f371fa49459a8eaaebc90b216b328daf2b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0101268d39289d2b1391ac557f3b79a7f8fb984d754aa3cdcff7e16d87d55189',
     armv7l: '0101268d39289d2b1391ac557f3b79a7f8fb984d754aa3cdcff7e16d87d55189',
       i686: '643ba2e3e17488c548bec58c6c898bad54a9fb23dc187e5c156c10880ef0e7d3',
     x86_64: 'c7536184e670ec649a4233dc2f5f54470472d934cfd73a0acd76ff2891d502dd'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv' => :build
end
