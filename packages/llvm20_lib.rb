require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm20_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm20_build.homepage
  version '20.1.0'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm20_build.version}".orange if version != Llvm20_build.version
  license Llvm20_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e4d04dfea09b81876d97b1e61c2e79fc8f8d9ae15bb05ecbb1c1926e76586cb',
     armv7l: '2e4d04dfea09b81876d97b1e61c2e79fc8f8d9ae15bb05ecbb1c1926e76586cb',
       i686: '12979a9e7112597d1a93c0174f57fe1612e356e56da18e47d6c767e37ca5b47b',
     x86_64: '827f1da7c81ddd361b9fdd39909f31c574529406e58cbcfaef8b7773392449c0'
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
