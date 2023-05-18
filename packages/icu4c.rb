require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '72.1-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-72-1/icu4c-72_1-src.tgz'
  source_sha256 'a2d2d38217092a7ed56635e34467f92f976b370e20182ad325edea6681a71d68'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72.1-1_armv7l/icu4c-72.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72.1-1_armv7l/icu4c-72.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72.1-1_i686/icu4c-72.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/72.1-1_x86_64/icu4c-72.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9ad0f6474bb946741894b8617b98e8fbf32425c63180fa423976030528a68fec',
     armv7l: '9ad0f6474bb946741894b8617b98e8fbf32425c63180fa423976030528a68fec',
       i686: 'e5615e175709b26a73c1721816fa68a704de2580fddb1ab76c58d89d721693af',
     x86_64: '7b759ad277ee961d76520a430cd50f2245758490110933d8af326fb3345c8691'
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
        --disable-samples \
        --disable-tests"
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
    # Check for packages that expect an older icu library, but not in a container, since we have already
    # checked all obvious packages there.
    return if CREW_IN_CONTAINER

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
        # Mozjs contains an internal icu which will not match this version.
        # Update the following when there is a new version of mozjs.
        @fileArray.delete_if { |item| item == 'js102' }
        next if @fileArray.empty?

        @fileArray.uniq.sort.each do |item|
          puts item.lightred
        end
      end
    end
  end
end
