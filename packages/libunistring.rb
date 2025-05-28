require 'buildsystems/autotools'

class Libunistring < Autotools
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '1.3'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libunistring/libunistring-#{version}.tar.xz"
  source_sha256 'f245786c831d25150f3dfb4317cda1acc5e3f79a5da4ad073ddca58886569527'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88819e46b327cf7343afb2b419b9c25fa3653a60175201c6aaf65a6657d91ca4',
     armv7l: '88819e46b327cf7343afb2b419b9c25fa3653a60175201c6aaf65a6657d91ca4',
       i686: '97013a4bf631d40ef21f4302bee0283475372ed48ce00c04d888dfdca7ff7851',
     x86_64: '33f8c9f1c6a7a333637f03f5f117b895a716092da2fdaddf6d1b7dad028ba6d1'
  })

  depends_on 'glibc'

  autotools_configure_options '--enable-static \
      --enable-shared'
end
