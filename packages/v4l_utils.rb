require 'package'

class V4l_utils < Package
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  version '1.22.1'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://linuxtv.org/downloads/v4l-utils/v4l-utils-#{version}.tar.bz2"
  source_sha256 '65c6fbe830a44ca105c443b027182c1b2c9053a91d1e72ad849dfab388b94e31'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99bfc727cc7dc8669f57e981f8659e8278007e61c9425101f5ea6d27e3d9c2b1',
     armv7l: '99bfc727cc7dc8669f57e981f8659e8278007e61c9425101f5ea6d27e3d9c2b1',
       i686: '6eae363af21be86b15581d1e95bac828c2007e0786aadba6aedd9ebaea318543',
     x86_64: '10c0384638fef3657f01129ce225a640ac182823f472d35aa48bfc3a39da7a5f'
  })

  depends_on 'alsa_lib'
  depends_on 'eudev'
  depends_on 'libglu'
  depends_on 'libjpeg'
  depends_on 'mesa' unless ARCH == 'i686'
  depends_on 'qt5_base' unless ARCH == 'i686'
  depends_on 'sdl2_image'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    system "find . -name '*.pl' -exec sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' {} +"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --disable-bpf"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
