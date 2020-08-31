require 'package'

class Libportal < Package
  description 'libportal provides GIO-style async APIs for most Flatpak portals.'
  homepage 'https://github.com/flatpak/libportal'
  version '0.3'
  compatibility 'all'
  source_url 'https://github.com/flatpak/libportal/releases/download/0.3/libportal-0.3.tar.xz'
  source_sha256 'fd35d66357169e63e33ef46c43fdf22ddc07dbd960ec3462b58ca9ef15a65bd7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libportal-0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libportal-0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libportal-0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libportal-0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '40fd03920ab3921bb7b40580da67071c3fd6fc58dd6b4329fce2c36a6a36b54c',
     armv7l: '40fd03920ab3921bb7b40580da67071c3fd6fc58dd6b4329fce2c36a6a36b54c',
       i686: '9958d65c373711027353a478a51fdce534a58891f3212edecd14e4727cf05416',
     x86_64: '3a2b74f4d9b3faf92d55e545f891475470c97eda8baac143142e3b669bc1b34a',
  })

  def self.prebuild
    # Disable doc
    system "sed -i '38d' meson.build"
  end

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --buildtype=release _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
