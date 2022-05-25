require 'buildsystems/autotools'

class Libogg < Autotools
  description 'Ogg is a multimedia container format, and the native file and stream format for the Xiph.org multimedia codecs.'
  homepage 'https://xiph.org/ogg/'
  version '1.3.5-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/ogg/libogg-1.3.5.tar.xz'
  source_sha256 'c4d91be36fc8e54deae7575241e03f4211eb102afb3fc0775fbbc1b740016705'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libogg/1.3.5-1_armv7l/libogg-1.3.5-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libogg/1.3.5-1_armv7l/libogg-1.3.5-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libogg/1.3.5-1_i686/libogg-1.3.5-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libogg/1.3.5-1_x86_64/libogg-1.3.5-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fe9269e8083da01203ad5b5182dcd54dda35444e51c8d5e4f349f052b7c5811c',
     armv7l: 'fe9269e8083da01203ad5b5182dcd54dda35444e51c8d5e4f349f052b7c5811c',
       i686: 'fa445ecacf8135aa50814c892058ecf8d9fa4c060821b3b237836dc84c0b5d1d',
     x86_64: '7d919816470818a0b07c85979f2a08f86c70fae69137e0274b013ab4bf404e84'
  })

  depends_on 'glibc' # R
end
