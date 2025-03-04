require 'buildsystems/autotools'

class Dehtml < Autotools
  description 'Dehtml removes HTML constructs from documents for indexing, spell checking and so on.'
  homepage 'http://www.moria.de/~michael/dehtml/'
  version '1.8'
  license 'GPL-2+'
  compatibility 'all'
  source_url "http://www.moria.de/~michael/dehtml/dehtml-#{version}.tar.gz"
  source_sha256 'a00e86643b0aa73861e9d8d619a80370f0f99519d34ce12459fab77f5f6b5bde'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'eb13507fc8eb05871a4af0fc5a67399bed4aaddb963e36d4d77f13ffb2af4da6',
     x86_64: '5788fbdec1e02e91412c869b23b813144894e4a2715faa865f1f0421dc7c6315'
  })

  depends_on 'glibc' # R
end
