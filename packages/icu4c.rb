require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '68.1'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-68-1/icu4c-68_1-src.tgz'
  source_sha256 'a9f2e3d8b4434b8e53878b4308bd1e6ee51c9c7042e2b1a376abefb6fbb29f2d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b49e0c6c754f3b019d769d9c9eb54aa04f6374e25481b3c01611d886a791caed',
     armv7l: 'b49e0c6c754f3b019d769d9c9eb54aa04f6374e25481b3c01611d886a791caed',
       i686: 'cd5f09ba3b1b9f12fe553f8b52f8cacec9d5541c4f0d1fad74f6f8137c09ed99',
     x86_64: '07ddbfffe6b0790289c741f4da5f2e8d341b5194f069ec5a5026ba85bbcfcee2',
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
