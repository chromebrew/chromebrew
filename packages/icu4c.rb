require 'buildsystems/autotools'

class Icu4c < Autotools
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'https://icu.unicode.org/'
  version '77.1'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/unicode-org/icu/releases/download/release-#{version.gsub('.', '-')}/icu4c-#{version.gsub('.', '_')}-src.tgz"
  source_sha256 '588e431f77327c39031ffbb8843c0e3bc122c211374485fa87dc5f3faff24061'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40c21ff2e336c88d9a42fc3733bc6503bf0988fa86daa02d805d4fbced6d375c',
     armv7l: '40c21ff2e336c88d9a42fc3733bc6503bf0988fa86daa02d805d4fbced6d375c',
       i686: 'c73b71b09ca4ddf4d362ecc26f02b0da42fd9fbe9ff82340f2943b90c9622b18',
     x86_64: 'f4cb68ef8ba4e50dd3069ed792295dbcd4ea122dd1335b1c12c5b58bce97e007'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

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
      @oldicuver = %w[75.1]
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
