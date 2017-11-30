require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '60.1'
  source_url 'http://download.icu-project.org/files/icu4c/60.1/icu4c-60_1-src.tgz'
  source_sha256 'f8f5a6c8fbf32c015a467972bdb1477dc5f5d5dfea908b6ed218715eeb5ee225'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-60.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-60.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-60.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-60.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0966765530795fb323aa924ea66e468cb33ff012a4a873ad5b03fd919ffa437f',
     armv7l: '0966765530795fb323aa924ea66e468cb33ff012a4a873ad5b03fd919ffa437f',
       i686: '367d86638f8722530ef21c631a2df7195790cf1610e39d6ff37cca5c191bbec8',
     x86_64: 'a35e8d783180ffce19cb1a1bb9bf7ad29cfc33427fb2baf451afdc81d0680592',
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
