require 'package'
require_relative 'llvm18_build'

class Llvm18_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm18_build.homepage
  version '18.1.0'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license Llvm18_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44abb4dbc82c8ed453fa506fdf8969a438786ddbaee57f4989d8804d3042379b',
     armv7l: '44abb4dbc82c8ed453fa506fdf8969a438786ddbaee57f4989d8804d3042379b',
       i686: 'b595b470ba6264b65f18294b2de10a4abf27948381ea72f6004c3e976327dd8d',
     x86_64: '545927a82a3c7a47236b03ca0d8573c495c05f9542b9f015ef0b5c8e264de9b9'
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
