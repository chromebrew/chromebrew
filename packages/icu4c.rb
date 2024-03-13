require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '74.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-74-2/icu4c-74_2-src.tgz'
  source_sha256 '68db082212a96d6f53e35d60f47d38b962e9f9d207a74cfac78029ae8ff5e08c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba5ef6142433e681a2e3b2c03b1e6cf5c3a685e065a1013e45ec2853ebc87c99',
     armv7l: 'ba5ef6142433e681a2e3b2c03b1e6cf5c3a685e065a1013e45ec2853ebc87c99',
       i686: '94fd8261f60025bc3666f3636678d094dd36a78fc3380bfae17d07b289ebcd0b',
     x86_64: '2c3cc278326f762e965c9d34f51fff11be983d3b4c3af526f79b726d55d25804'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    # case ARCH
    # when 'aarch64', 'armv7l'
      # # Armhf requires sane ELF headers rather than other architectures as
      # # discussed in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=653457
      # system "sed -e '/LDFLAGSICUDT=/cLDFLAGSICUDT=' -i source/config/mh-linux"
    # end
  end

  def self.build
    Dir.chdir 'source' do
      system "mold -run ./configure \
        #{CREW_OPTIONS} \
        --enable-static \
        --enable-shared \
        --disable-samples \
        --disable-tests"
      system 'make'
    end
  end

  @icuver = '74.2'
  @oldicuver = %w[73.2]

  def self.install
    Dir.chdir 'source' do
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
      @oldicuver = %w[73.2 72 72.1]
      @oldicuver.each do |oldver|
        puts "Finding Packages expecting icu4c version #{oldver} that may need updating:".lightgreen
        @file_array = []
        @lib_array = []
        @nmresults = `nm  -A *.so* 2>/dev/null | grep ucol_open_#{oldver}`.chop.split(/$/).map(&:strip)
        @nmresults.each { |file_line| @lib_array.push(file_line.partition(':').first) }
        @lib_array.each do |f|
          @grepresults = `grep "#{f}" #{CREW_META_PATH}/*.filelist`.chomp.gsub('.filelist', '').partition(':').first.gsub(
            CREW_META_PATH, ''
          ).split(/$/).map(&:strip)
          @grepresults.each { |file_line| @file_array.push(file_line) }
        end
        # Mozjs contains an internal icu which will not match this version.
        # Update the following when there is a new version of mozjs.
        @file_array.delete_if { |item| item == 'js102' }
        next if @file_array.empty?

        @file_array.uniq.sort.each do |item|
          puts item.lightred
        end
      end
    end
  end
end
