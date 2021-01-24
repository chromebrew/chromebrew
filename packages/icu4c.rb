require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '68.2'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-68-2/icu4c-68_2-src.tgz'
  source_sha256 'c79193dee3907a2199b8296a93b52c5cb74332c26f3d167269487680d479d625'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '35dfc0e95c0d6c09a323fd6ec393dc48e33940fc7815a4f51adff5a63f99416a',
      armv7l: '35dfc0e95c0d6c09a323fd6ec393dc48e33940fc7815a4f51adff5a63f99416a',
        i686: '1c45fb6c19db175fba61dd9925b648955c5081ad7dea31feb7b613b5ca0a97c9',
      x86_64: '290087e9c03a94eaf5d33a82b76dc3b5bb11be1dff5a6e57aa190ec5439bcfb2',
  })

  def self.build
    FileUtils.cd('source') do

      case ARCH
      when 'aarch64', 'armv7l'
        # Armhf requires sane ELF headers rather than other architectures as
        # discussed in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=653457
        system "sed -e '/LDFLAGSICUDT=/cLDFLAGSICUDT=' -i config/mh-linux"
      end
      system "env CFLAGS='-pipe -flto' CXXFLAGS='-pipe -flto' ./configure #{CREW_OPTIONS} --without-samples --without-tests"
      system 'make'
    end
  end

  def self.install
    FileUtils.cd('source') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      # Backwards compatibility symlinks
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libicudata.so.68", "#{CREW_DEST_LIB_PREFIX}/libicudata.so.67"
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libicui18n.so.68", "#{CREW_DEST_LIB_PREFIX}/libicui18n.so.67"
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libicuio.so.68", "#{CREW_DEST_LIB_PREFIX}/libicuio.so.67"
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libicutest.so.68", "#{CREW_DEST_LIB_PREFIX}/libicutest.so.67"
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libicutu.so.68", "#{CREW_DEST_LIB_PREFIX}/libicutu.so.67"
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libicuuc.so.68", "#{CREW_DEST_LIB_PREFIX}/libicuuc.so.67"
    end
  end
end
