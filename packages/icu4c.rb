require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '72rc-b3'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/archive/refs/tags/release-72-rc-cldr-beta3.tar.gz'
  source_sha256 '4d89f270dafc4ff39d1acab795bf4d471ba1f78a1704aef28a5ba75fae3d6c3c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72rc-b3_armv7l/icu4c-72rc-b3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72rc-b3_armv7l/icu4c-72rc-b3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72rc-b3_i686/icu4c-72rc-b3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72rc-b3_x86_64/icu4c-72rc-b3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '940f01954eb6424b03103c2e80d1a103580f1a8c180272eae3fac528933dcb91',
     armv7l: '940f01954eb6424b03103c2e80d1a103580f1a8c180272eae3fac528933dcb91',
       i686: '9683cc636aa88239ae4ab1e20f2d3346f9a163551cf01a8a2eec81ddecf82ab4',
     x86_64: 'fb4ab173a2a6cbe17345f3154f96617f3b3215546e75ee99d49086d683812259'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R

  def self.build
    FileUtils.cd('icu4c/source') do
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
        --disable-samples \
        --disable-tests"
      system 'mold -run make'
    end
  end

  @icuver = '72'
  @oldicuver = %w[67 68 69 71]

  def self.install
    FileUtils.cd('icu4c/source') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    Dir.chdir CREW_DEST_LIB_PREFIX do
      @oldicuver.each do |oldver|
        # Backwards compatibility symlinks (which may not work - see postinstall.)
        FileUtils.ln_sf "libicudata.so.#{@icuver}", "libicudata.so.#{oldver}"
        FileUtils.ln_sf "libicui18n.so.#{@icuver}", "libicui18n.so.#{oldver}"
        FileUtils.ln_sf "libicuio.so.#{@icuver}", "libicuio.so.#{oldver}"
        FileUtils.ln_sf "libicutest.so.#{@icuver}", "libicutest.so.#{oldver}"
        FileUtils.ln_sf "libicutu.so.#{@icuver}", "libicutu.so.#{oldver}"
        FileUtils.ln_sf "libicuuc.so.#{@icuver}", "libicuuc.so.#{oldver}"
      end
    end
  end

  def self.postinstall
    # Check for packages that expect an older icu library.
    Dir.chdir CREW_LIB_PREFIX do
      @oldicuver.each do |oldver|
        puts "Finding Packages expecting icu4c version #{oldver} that may need updating:".lightgreen
        @fileArray = []
        @libArray = []
        @nmresults = `nm  -A *.so* 2>/dev/null | grep ucol_open_#{oldver}`.chop.split(/$/).map(&:strip)
        @nmresults.each { |fileLine| @libArray.push(fileLine.partition(':').first) }
        @libArray.each do |f|
          @grepresults = `grep "#{f}" #{CREW_META_PATH}*.filelist`.chomp.gsub('.filelist', '').partition(':').first.gsub(
            CREW_META_PATH, ''
          ).split(/$/).map(&:strip)
          @grepresults.each { |fileLine| @fileArray.push(fileLine) }
        end
        next if @fileArray.empty?

        @fileArray.uniq.sort.each do |item|
          puts item.lightred
        end
      end
    end
  end
end
