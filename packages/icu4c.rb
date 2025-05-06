require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'https://icu.unicode.org/'
  version '75.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/icu/releases/download/release-75-1/icu4c-75_1-src.tgz'
  source_sha256 'cb968df3e4d2e87e8b11c49a5d01c787bd13b9545280fc6642f826527618caef'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ff2ed4760529e3611a51211876c17df5c9acc5a689cd35cb5a98ce0c4c1f714',
     armv7l: '2ff2ed4760529e3611a51211876c17df5c9acc5a689cd35cb5a98ce0c4c1f714',
       i686: '3bab33be0214ced3080b895c615ee8f9bf3b98e191701be0917c2e02c783c26f',
     x86_64: '83e81c0d8bb9981034d6d63755ac0e9ae833d9544cbc07e32d242e98cf3d30db'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    Dir.chdir 'source' do
      system "./configure \
        #{CREW_CONFIGURE_OPTIONS} \
        --enable-shared \
        --disable-samples \
        --disable-tests"
      system 'make'
    end
  end

  @oldicuver = %w[version.split('.').first.to_i - 1]

  def self.install
    Dir.chdir 'source' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    Dir.chdir CREW_DEST_LIB_PREFIX do
      @oldicuver.each do |oldver|
        # Backwards compatibility symlinks (which may not work - see postinstall.)
        FileUtils.ln_sf "libicudata.so.#{version}", "libicudata.so.#{oldver}"
        FileUtils.ln_sf "libicui18n.so.#{version}", "libicui18n.so.#{oldver}"
        FileUtils.ln_sf "libicuio.so.#{version}", "libicuio.so.#{oldver}"
        FileUtils.ln_sf "libicutest.so.#{version}", "libicutest.so.#{oldver}"
        FileUtils.ln_sf "libicutu.so.#{version}", "libicutu.so.#{oldver}"
        FileUtils.ln_sf "libicuuc.so.#{version}", "libicuuc.so.#{oldver}"
      end
    end
  end

  def self.postinstall
    # Check for packages that expect an older icu library, but not in a container, since we have already
    # checked all obvious packages there.
    return if CREW_IN_CONTAINER

    Dir.chdir CREW_LIB_PREFIX do
      @oldicuver = %w[74.2 73.2 73 72 72.1]
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
        @file_array.delete_if { |item| item == 'js115' }
        next if @file_array.empty?

        @file_array.uniq.sort.each do |item|
          puts item.lightred
        end
      end
    end
  end
end
