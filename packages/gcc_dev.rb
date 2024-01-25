require 'package'
require_relative 'gcc_build'

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  version '13.2.0' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version differs from gcc version #{Gcc_build.version}".orange if version.to_s.gsub(/-.*/,
                                                                                                   '') != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a717ebcc89594924305bae1bdb7b083ef061c9b57aec15e2cc0450ff2790a62c',
     armv7l: 'a717ebcc89594924305bae1bdb7b083ef061c9b57aec15e2cc0450ff2790a62c',
       i686: 'cc9d4618f445cafb7e3cdf227032ebbddd1d1b71147996d93123563b0dd18015',
     x86_64: 'cc8a2c48193128c461f525709812474423b1b4d4856663784d01d2c8caa8a22b'
  })

  depends_on 'gcc_build' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'isl' # R
  depends_on 'libssp' # L
  depends_on 'mpc' # R
  depends_on 'mpfr' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R
  no_shrink
  no_strip

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next if filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
