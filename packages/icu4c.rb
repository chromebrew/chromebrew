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
    aarch64: 'c9bd508bd52785175f4584b55d42e0da014065f5605be59f7896a89170a141cb',
     armv7l: 'c9bd508bd52785175f4584b55d42e0da014065f5605be59f7896a89170a141cb',
       i686: '88f8dec20c7f5135ac70be3bbb07f61d7bcab2880d098ae68d2c63cbfe45699b',
     x86_64: 'e57e0d659d1729280e9f89835496e1776860acc4879614e65f534accebbb4c71'
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
