require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '62.1'
  compatibility 'all'
  source_url 'https://download.icu-project.org/files/icu4c/62.1/icu4c-62_1-src.tgz'
  source_sha256 '3dd9868d666350dda66a6e305eecde9d479fb70b30d5b55d78a1deffb97d5aa3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-62.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-62.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-62.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-62.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c147083d3a6bbc5757fd0a0e01ea131a4cb0bb668ed6a3624ee811e02c21b836',
     armv7l: 'c147083d3a6bbc5757fd0a0e01ea131a4cb0bb668ed6a3624ee811e02c21b836',
       i686: '690dcc70dde735c24a6f26d54c41b17e78ea03dd37025ea51c2d1d300e8c88a0',
     x86_64: '3ac1b0401d0af3b4357a6874bd069deb8aca472dc1bd23d455e1f90ae7736262',
  })

  def self.build
    FileUtils.cd('source') do
      case ARCH
      when 'aarch64', 'armv7l'
        # Armhf requires sane ELF headers rather than other architectures as
        # discussed in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=653457
        system "sed -e '/LDFLAGSICUDT=/cLDFLAGSICUDT=' -i config/mh-linux"
      end
      system "./configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--without-samples",
             "--without-tests"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('source') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
