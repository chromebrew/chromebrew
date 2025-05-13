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
    aarch64: 'e671666a05946c3df0cbf42348eed82075958e41be4428be0677c0989b9fde2f',
     armv7l: 'e671666a05946c3df0cbf42348eed82075958e41be4428be0677c0989b9fde2f',
       i686: '273a93fd6b09b4a58fa442510c6acec376d792373c98d718d3422d90463af082',
     x86_64: '8555d6ac52bb8efa833f26ff62348aff5f9bf1865c224b0e2778118f9ae8b0f5'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv' => :build
end
