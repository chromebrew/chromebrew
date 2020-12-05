require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://github.com/fribidi/fribidi/archive/v1.0.10.tar.gz'
  source_sha256 '3ebb19c4184ed6dc324d2e291d7465bc6108a20be019f053f33228e07e879c4f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1200e97b55266d2640939faf5d63fb587819d699f248ff65a957263f346e9546',
     armv7l: '1200e97b55266d2640939faf5d63fb587819d699f248ff65a957263f346e9546',
       i686: '85d3bb92cfbaeacd1c59e68a1be89837f4c626ff8c7b12a754550030ea64b1f9',
     x86_64: 'c6785afffafa8144c59319e6629566b3d984f0af685c0ae5acc928bc4f3522fa',
  })

  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Ddocs=false -Dtests=false build"
    system 'meson configure build'
    system 'ninja -v -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
