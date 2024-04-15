require 'package'
require_relative 'llvm18_build'

class Llvm18_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm18_build.homepage
  version '18.1.3'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license Llvm18_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8fc9c37f92ba7c8e79a7ffd892bf350331d3c16587361c5c8454094731d9819',
     armv7l: 'd8fc9c37f92ba7c8e79a7ffd892bf350331d3c16587361c5c8454094731d9819',
       i686: 'bcc2b032e45d19a3501d4861fcaa73f48776c49385a336ff796efb2c341bae65',
     x86_64: 'bb04562aa7ff0b2157d842bb22c58ca482a3b26b4a97c7f8c02cdc3263729237'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm18_build' => :build
  depends_on 'ncurses' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm18_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm18_build.filelist')
    abort 'File list for llvm18_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
