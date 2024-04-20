require 'package'
require_relative 'llvm18_build'

class Llvm18_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm18_build.homepage
  version '18.1.4'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license Llvm18_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '745342866f1e990eade5382f5ce68874b1ca9f85bb527ce27c9121c416fee827',
     armv7l: '745342866f1e990eade5382f5ce68874b1ca9f85bb527ce27c9121c416fee827',
       i686: '82dbb173c59858b8b3db78c36d2cda6904bdec56f7ff0ca89dab599489f2d54c',
     x86_64: '8bf18d04ba64f8262e5c896cb117d94d123fc8746a98740e4a82d337d7c89d4a'
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
