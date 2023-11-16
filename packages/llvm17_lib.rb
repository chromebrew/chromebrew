require 'package'
require_relative 'llvm17_build'

class Llvm17_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm17_build.homepage
  version '17.0.5'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm17_build.version}".orange if version != Llvm17_build.version
  license Llvm17_build.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.5_armv7l/llvm17_lib-17.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.5_armv7l/llvm17_lib-17.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.5_i686/llvm17_lib-17.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.5_x86_64/llvm17_lib-17.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fec802f43c067ea9afb53cd94e4efd5cb4fa3c13622dba74538f1bf7499cd334',
     armv7l: 'fec802f43c067ea9afb53cd94e4efd5cb4fa3c13622dba74538f1bf7499cd334',
       i686: 'bdb3f09e48307e6356c581fca053ee72369a4345e11773ecefe9c3faa149f159',
     x86_64: '6a3565f6d9fa172040bc54cd31cf85ea8627bd7b60bd9081719bebb4a0181e81'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm17_build' => :build
  depends_on 'ncurses' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  no_shrink
  no_strip

  def self.install
    puts 'Installing llvm17_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm17_build.filelist')
    abort 'File list for llvm17_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
