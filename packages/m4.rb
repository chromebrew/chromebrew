require 'buildsystems/autotools'

class M4 < Autotools
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.19-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/m4/m4-1.4.19.tar.xz'
  source_sha256 '63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96'
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
