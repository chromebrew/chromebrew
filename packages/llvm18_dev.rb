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
    aarch64: '3311d1a9c617207fa553e1b287ef2f60868cd84d80bab903409493a9f24d2b6d',
     armv7l: '3311d1a9c617207fa553e1b287ef2f60868cd84d80bab903409493a9f24d2b6d',
       i686: 'bc91fd5124194a36ee0076e1205e9c80b0fbb15466c12842bf499d16d9b00e8c',
     x86_64: 'ce86f315fbab69c4bf3bcd67981fec1f6380e3650ee8e8c259fef7a49b2014e2'
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
