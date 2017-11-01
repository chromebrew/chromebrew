require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '58.2'
  source_url 'http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz'
  source_sha256 '2b0a4410153a9b20de0e20c7d8b66049a72aef244b53683d0d7521371683da0c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-58.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-58.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-58.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-58.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb69b07ae6fddc0cd3b792c1323356b34b130da23a73cee1fee49cd5bd24ca7d',
     armv7l: 'cb69b07ae6fddc0cd3b792c1323356b34b130da23a73cee1fee49cd5bd24ca7d',
       i686: '8832fa1078db6b813c88b38d525301c8aa53c78924d229e6294ed42b29b0f047',
     x86_64: '3552b06091444f5af6985a29d273f9db692a90c4eba9bc5478396f4b05eec6a3',
  })

  def self.build
    FileUtils.cd('source') do
      case ARCH
      when 'aarch64', 'armv7l'
        # Armhf requires sane ELF headers rather than other architectures as
        # discussed in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=653457
        system "sed -e '/LDFLAGSICUDT=/cLDFLAGSICUDT=' -i config/mh-linux"
      end
      system "./configure", "--without-samples", "--without-tests"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('source') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
