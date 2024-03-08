require 'package'
require_relative 'llvm18_build'

class Llvm18_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm18_build.homepage
  version '18.1.0'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license Llvm18_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c239a12d6436cc66e6ef32f5e0b2584ca80aaf94fdfd2bea4adfdecc72554fd6',
     armv7l: 'c239a12d6436cc66e6ef32f5e0b2584ca80aaf94fdfd2bea4adfdecc72554fd6',
       i686: '846ced24b054d23942d054193ba1cfc7cd4b9a6710bf9559f611a73e60d04e17',
     x86_64: 'ff61954333d270c18d83210478c10559886c5f217097cdb930cf2bd82f9ef6da'
  })

  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm18_build' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'ncurses' # R
  depends_on 'xzutils' # R
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
      next if filename.include?('.so') && filename.include?('libLLVM')
      next if filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
