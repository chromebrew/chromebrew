require 'package'

class Yaru < Package
  description 'Yaru default ubuntu theme'
  version '20.10.6.1-c80b'
  compatibility 'all'
  source_url 'https://github.com/ubuntu/yaru/archive/c80b62c991b98be235dee97c4fc657de6bf23895.zip'
  source_sha256 '70571c88f193b5f371352f0cc93cf4b941f2e6cf6a85bb4b250561b16dbfdfe8'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yaru-20.10.6.1-c80b-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yaru-20.10.6.1-c80b-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yaru-20.10.6.1-c80b-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yaru-20.10.6.1-c80b-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a9fd00aec4d18c30b19e83d053100d853196a7a915b05f58e06e58a3e1265969',
     armv7l: 'a9fd00aec4d18c30b19e83d053100d853196a7a915b05f58e06e58a3e1265969',
       i686: 'd51f3c148cfab707d59a261162a2aa4f279cc678a078262069756fa09aeff8e9',
     x86_64: '2ddef44b4a62611ce21890cc34ac4da45d39cbcd03c721f34b2bd5de02dc804f'
  })

  depends_on 'sassc'

  def self.build
    system "meson setup #{CREW_MESON_LTO_OPTIONS} \
      -Dubuntu-unity=true \
      build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
