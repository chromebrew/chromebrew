require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm20_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm20_build.homepage
  version '20.1.3'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm20_build.version}".orange if version != Llvm20_build.version
  license Llvm20_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e0a85afefbf96eaa75f101b46ba2353ba7d9193713bfc3f16174e8c7f4fecc8',
     armv7l: '0e0a85afefbf96eaa75f101b46ba2353ba7d9193713bfc3f16174e8c7f4fecc8',
       i686: 'c598d9e062577aebfa163a3c0e1d85fee2ff50f9afe0b68839cf16f98296ec2c',
     x86_64: 'd7f83da8adfc35a28b60841d2f02077c714df8701a3f262641e6e39e998a62dd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libxml2' # R
  depends_on 'llvm20_build' => :build
  depends_on 'llvm20_lib' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm20_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm20_build.filelist')
    abort 'File list for llvm20_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next if filename.include?('.so') && filename.include?('libLLVM')
      next if filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
