require 'buildsystems/autotools'

class Flac < Autotools
  description 'FLAC stands for Free Lossless Audio Codec, an audio format similar to MP3, but lossless, meaning that audio is compressed in FLAC without any loss in quality.'
  homepage 'https://xiph.org/flac/'
  version '1.4.3'
  license 'BSD, FDL-1.2, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/flac/flac-1.4.3.tar.xz'
  source_sha256 '6c58e69cd22348f441b861092b825e591d0b822e106de6eb0ee4d05d27205b70'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flac/1.4.3_armv7l/flac-1.4.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flac/1.4.3_armv7l/flac-1.4.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flac/1.4.3_i686/flac-1.4.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flac/1.4.3_x86_64/flac-1.4.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f0b9a35c35a3be20185cca981650dd7ba33550505c7853fa52e0eec823181a8d',
     armv7l: 'f0b9a35c35a3be20185cca981650dd7ba33550505c7853fa52e0eec823181a8d',
       i686: '863ad1e4a367536471713f192db032f5cf6521652ab55220b900f0d7118cf562',
     x86_64: 'eb70328f8034cdcbb8047ffe15f42555b048ae111f0ba4001d5c282f6c59ee42'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libogg' # R
end
