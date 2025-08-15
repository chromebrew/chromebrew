require 'buildsystems/meson'

class V4l_utils < Meson
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  version '1.30.1'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://git.linuxtv.org/v4l-utils.git'
  git_hashtag "v4l-utils-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3eb9ec864c535a0ce21320ab9f9e418ca8ce60013faf3dcb41acb9d7ba5d933e',
     armv7l: '3eb9ec864c535a0ce21320ab9f9e418ca8ce60013faf3dcb41acb9d7ba5d933e',
       i686: '2065dcfdc06ed64da8703b2d628302b0742aff961b8b5e12923c0039fe1d398c',
     x86_64: 'a86fc202446566f0268f27306bd9bfa8dea1161c180416ad196db48bf616cb48'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo'

  def self.patch
    system "find . -name '*.pl' -exec sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' {} +"
  end
end
