require 'package'

class Libbluray < Package
  description 'This library is simply a tool for playback of Blu-ray movies.'
  homepage 'https://www.videolan.org/developers/libbluray.html'
  version '1.3.0'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://get.videolan.org/libbluray/1.3.0/libbluray-1.3.0.tar.bz2'
  source_sha256 'e2dbaf99e84e0a9725f4985bcb85d41e52c2261cc651d8884b1b790b5ef016f9'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbluray/1.3.0_armv7l/libbluray-1.3.0-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbluray/1.3.0_armv7l/libbluray-1.3.0-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbluray/1.3.0_i686/libbluray-1.3.0-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbluray/1.3.0_x86_64/libbluray-1.3.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bf82630d544040492dd6d8d9f835ef448c6cce5752a50958b564bc17517fec60',
      armv7l: 'bf82630d544040492dd6d8d9f835ef448c6cce5752a50958b564bc17517fec60',
        i686: '7968c7490139a96a4743f4f0edbc68f2c3c23f74edcde269ad8e70afc6dab9a9',
      x86_64: '06216dc7ac94c9cc1d4e86b67a8502e1550a0daf66865b24593c578d0e38435a'
  })

  depends_on 'libxml2'
  depends_on 'freetype'
  depends_on 'fontconfig'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --enable-optimizations \
            --disable-bdjava-jar"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
