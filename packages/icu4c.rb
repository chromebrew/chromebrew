require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '73.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-73-2/icu4c-73_2-src.tgz'
  source_sha256 '818a80712ed3caacd9b652305e01afc7fa167e6f2e94996da44b90c2ab604ce1'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/73.2_armv7l/icu4c-73.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/73.2_armv7l/icu4c-73.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/73.2_i686/icu4c-73.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icu4c/73.2_x86_64/icu4c-73.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ba5ef6142433e681a2e3b2c03b1e6cf5c3a685e065a1013e45ec2853ebc87c99',
     armv7l: 'ba5ef6142433e681a2e3b2c03b1e6cf5c3a685e065a1013e45ec2853ebc87c99',
       i686: '94fd8261f60025bc3666f3636678d094dd36a78fc3380bfae17d07b289ebcd0b',
     x86_64: '2c3cc278326f762e965c9d34f51fff11be983d3b4c3af526f79b726d55d25804'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    FileUtils.cd('source') do
      case ARCH
      when 'aarch64', 'armv7l'
        # Armhf requires sane ELF headers rather than other architectures as
        # discussed in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=653457
        system "sed -e '/LDFLAGSICUDT=/cLDFLAGSICUDT=' -i config/mh-linux"
      end
      system "mold -run ./configure \
        #{CREW_OPTIONS} \
        --enable-static \
        --enable-shared \
        --disable-samples \
        --disable-tests"
      system 'make'
    end
  end

  @icuver = '73'
  @oldicuver = %w[73.1]

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
      @oldicuver = %w[72 72.1]
      @oldicuver.each do |oldver|
        puts "Finding Packages expecting icu4c version #{oldver} that may need updating:".lightgreen
        @fileArray = []
        @libArray = []
        @nmresults = `nm  -A *.so* 2>/dev/null | grep ucol_open_#{oldver}`.chop.split(/$/).map(&:strip)
        @nmresults.each { |fileLine| @libArray.push(fileLine.partition(':').first) }
        @libArray.each do |f|
          @grepresults = `grep "#{f}" #{CREW_META_PATH}/*.filelist`.chomp.gsub('.filelist', '').partition(':').first.gsub(
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
