require 'buildsystems/autotools'

class Icu4c < Autotools
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'https://icu.unicode.org/'
  version '78.3'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/unicode-org/icu/releases/download/release-#{version}/icu4c-#{version}-sources.tgz"
  source_sha256 '3a2e7a47604ba702f345878308e6fefeca612ee895cf4a5f222e7955fabfe0c0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a759777861ab3b14901acb532a07d9efc344768bd729aede94ba9924003257c8',
     armv7l: 'a759777861ab3b14901acb532a07d9efc344768bd729aede94ba9924003257c8',
       i686: '7615674fb743dc440020dfd6f998c9ff44a2ce4f96157c9ed4d4ab688314d903',
     x86_64: '4d43cb6d435d62cd0962ba37d286f73f23d45096ab5f127450b7f40470ceb16d'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  ignore_updater # Handle updates manually since so many packages need to be rebuilt with an icu4c update.

  autotools_make_j1
  autotools_build_relative_dir 'source'

  autotools_configure_options '--enable-shared \
        --disable-samples \
        --disable-tests'

  def self.postinstall
    # Check for packages that expect an older icu library, but not in a container, since we have already
    # checked all obvious packages there.
    return if CREW_IN_CONTAINER

    Dir.chdir CREW_LIB_PREFIX do
      @oldicuver = %w[77.1]
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
        @file_array.delete_if { |item| item == 'js140' }
        next if @file_array.empty?

        @file_array.uniq.sort.each do |item|
          puts item.lightred
        end
      end
    end
  end
end
