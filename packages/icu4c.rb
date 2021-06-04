require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '69.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-69-1/icu4c-69_1-src.tgz'
  source_sha256 '4cba7b7acd1d3c42c44bb0c14be6637098c7faf2b330ce876bc5f3b915d09745'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/69.1_armv7l/icu4c-69.1-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/69.1_armv7l/icu4c-69.1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/69.1_i686/icu4c-69.1-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/69.1_x86_64/icu4c-69.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '31aaafa8b65f82f0bd77e403c4cf3819b20ddfd8abd775996bbf740251244aeb',
    armv7l: '31aaafa8b65f82f0bd77e403c4cf3819b20ddfd8abd775996bbf740251244aeb',
    i686: 'bbb7320a1aac37f09c7f8eb96ed1fefc5f01bc7a85ed0ad1cc9dac2a781472ea',
    x86_64: '868a783d335eb13ff06d29b5221448a50e68a728ee1c35f3dc4c16c816716d68'
  })

  def self.build
    FileUtils.cd('source') do
      case ARCH
      when 'aarch64', 'armv7l'
        # Armhf requires sane ELF headers rather than other architectures as
        # discussed in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=653457
        system "sed -e '/LDFLAGSICUDT=/cLDFLAGSICUDT=' -i config/mh-linux"
      end
      system "./configure \
        #{CREW_OPTIONS} \
        #{CREW_ENV_OPTIONS} \
        --enable-static \
        --enable-shared \
        --without-samples \
        --without-tests"
      system 'make'
    end
  end

  def self.install
    FileUtils.cd('source') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    @icuver = '69'
    @oldicuver = %w[68 67]
    Dir.chdir CREW_DEST_LIB_PREFIX do
      @oldicuver.each do |oldver|
        # Backwards compatibility symlinks
        FileUtils.ln_sf "libicudata.so.#{@icuver}", "libicudata.so.#{oldver}"
        FileUtils.ln_sf "libicui18n.so.#{@icuver}", "libicui18n.so.#{oldver}"
        FileUtils.ln_sf "libicuio.so.#{@icuver}", "libicuio.so.#{oldver}"
        FileUtils.ln_sf "libicutest.so.#{@icuver}", "libicutest.so.#{oldver}"
        FileUtils.ln_sf "libicutu.so.#{@icuver}", "libicutu.so.#{oldver}"
        FileUtils.ln_sf "libicuuc.so.#{@icuver}", "libicuuc.so.#{oldver}"
      end
    end
  end
end
