require 'buildsystems/autotools'

class Libunistring < Autotools
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '1.4.2'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libunistring/libunistring-#{version}.tar.xz"
  source_sha256 '5b46e74377ed7409c5b75e7a96f95377b095623b689d8522620927964a41499c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '96f4210afe9743f15d4294f79f09213e12467a3d2085ecea9bc753b1ad66da1e',
     armv7l: '96f4210afe9743f15d4294f79f09213e12467a3d2085ecea9bc753b1ad66da1e',
       i686: '7264c0d67219f7183a51b5b5892b78d2699d345c803745d6872b707ebddf46dc',
     x86_64: '938cdcf6680fee8df992123a1fde0b3293eabf6936a09a51bd66ef46bbd7ea53'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--enable-static \
      --enable-shared'
end
