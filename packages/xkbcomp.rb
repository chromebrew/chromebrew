require 'package'

class Xkbcomp < Package
  description 'Compile XKB keyboard'
  homepage 'https://www.x.org'
  version '1.4.4'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/app/xkbcomp-1.4.4.tar.bz2'
  source_sha256 '59cce603a607a17722a0a1cf99010f4894e7812beb5d695abbc08474d59af27e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c654874e78a8da297b0bc5addc3a461e840366bdc333a010db05315f79497329',
     armv7l: 'c654874e78a8da297b0bc5addc3a461e840366bdc333a010db05315f79497329',
       i686: 'edf3af026fdc18ad32c0049d651c60c8b0b14f1d2712e2545a4ae093c2c2babd',
     x86_64: '5dbe7bc9bae31c26a4d0cb5a87e1655de43d05ed97307778df49a0b3fbbabaaa',
  })


  depends_on 'mesa'
  depends_on 'xcb_util'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "xkb configuration files are located in #{CREW_PREFIX}/share/X11/xkb".lightblue
    puts
  end
end
