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
    aarch64: '617d966e31c3300adfd2c8ca5ddbc2446a69a853eb2f60727d54359241844b38',
     armv7l: '617d966e31c3300adfd2c8ca5ddbc2446a69a853eb2f60727d54359241844b38',
       i686: 'ef650542e7a559299822a365ef229eabd282bd704d1d3b9d3fd7939ae9827238',
     x86_64: 'b290a8656cbbe76c6519f09d8d557910c0d8e7ddcbbdbba4092d871975562909'
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
