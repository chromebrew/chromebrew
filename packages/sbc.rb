require 'buildsystems/autotools'

class Sbc < Autotools
  description 'SBC is a digital audio encoder and decoder used to transfer data to Bluetooth audio output devices.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/multimedia/sbc.html'
  version '2.0'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/bluetooth/sbc-2.0.tar.xz'
  source_sha256 '8f12368e1dbbf55e14536520473cfb338c84b392939cc9b64298360fd4a07992'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94eb507ecb737f856ab6fd64d6fffbb56fa06fa17c3c9fd89b7f168dbd3836c0',
     armv7l: '94eb507ecb737f856ab6fd64d6fffbb56fa06fa17c3c9fd89b7f168dbd3836c0',
       i686: '7d910e200cf5edf6654369a94e6652b5af9989977ea3ec636fb2f900b72189e5',
     x86_64: '5fd600e8ab31ea0668acb2679787a99c94fef58cb222e843a7781a820636c3bd'
  })

  depends_on 'glibc' # R
  depends_on 'libsndfile' => :build

  configure_options '--enable-high-precision \
          --disable-static \
          --enable-pie'
end
