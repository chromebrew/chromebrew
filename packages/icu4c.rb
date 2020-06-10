require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '67.1'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-67-1/icu4c-67_1-src.tgz'
  source_sha256 '94a80cd6f251a53bd2a997f6f1b5ac6653fe791dfab66e1eb0227740fb86d5dc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-67.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-67.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-67.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-67.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ce53eb65aa3a48d328bfd117ff19d442dfb585d024ed88a194753da4f57d982e',
     armv7l: 'ce53eb65aa3a48d328bfd117ff19d442dfb585d024ed88a194753da4f57d982e',
       i686: '1a561f7e4e7d1b2f5ddc5af5e75367451c16ac0370a23b379f235b8d00f85098',
     x86_64: '7ef9cec7a0b06d27b6dcd92c3509ff6bfb0376d5adc710b1095965843b7ed4a6',
  })

  def self.build
    FileUtils.cd('source') do
      case ARCH
      when 'aarch64', 'armv7l'
        # Armhf requires sane ELF headers rather than other architectures as
        # discussed in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=653457
        system "sed -e '/LDFLAGSICUDT=/cLDFLAGSICUDT=' -i config/mh-linux"
      end
      system "./configure #{CREW_OPTIONS} --without-samples --without-tests"
      system 'make'
    end
  end

  def self.install
    FileUtils.cd('source') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
