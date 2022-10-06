require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '72rc'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-72-rc/icu4c-72rc-src.tgz'
  source_sha256 'e94cfb91fc0d1934449eadb28c68967b5b29d0c0916490ccd50098972a420a2d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72rc_armv7l/icu4c-72rc-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72rc_armv7l/icu4c-72rc-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72rc_i686/icu4c-72rc-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72rc_x86_64/icu4c-72rc-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'efb5bbf3f5bc2dbe9179f49d516d6fb101c58216a959901632606c551b53e16a',
     armv7l: 'efb5bbf3f5bc2dbe9179f49d516d6fb101c58216a959901632606c551b53e16a',
       i686: 'ea0b61a1552b4d67f8ebc857cf3e4701ecfd36d6b93eabd1a085dfd110c01bec',
     x86_64: '7c1d1b70f09f0bfd6df9038172c5eed6322e119ad5f582f1330d69472678dcca'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R

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
      system 'mold -run make'
    end
  end

  @icuver = '72'
  @oldicuver = %w[67 68 69 71]

  def self.install
    FileUtils.cd('source') do
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
