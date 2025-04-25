require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm20_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm20_build.homepage
  version '20.1.3'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm20_build.version}".orange if version != Llvm20_build.version
  license Llvm20_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ed2a366ec26f972efd788117cbd0a1cb98e52ceebe3d5acc8e1a7d6a1c56f85',
     armv7l: '0ed2a366ec26f972efd788117cbd0a1cb98e52ceebe3d5acc8e1a7d6a1c56f85',
       i686: 'd5d1a558bc1d154577b9a0dd5c7da62999911fe7cae33ddfaae25e8ebb6af3f1',
     x86_64: 'b6cd2e66f113d97f4453319d7457bbe20cf88dbccdf7fdfdcea50557ef7dfc45'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm20_build' => :build
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
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
