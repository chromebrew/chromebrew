require 'package'
require_relative 'llvm17_build'

class Llvm17_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm17_build.homepage
  version '17.0.6'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm17_build.version}".orange if version != Llvm17_build.version
  license Llvm17_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.6_armv7l/llvm17_lib-17.0.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.6_armv7l/llvm17_lib-17.0.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.6_i686/llvm17_lib-17.0.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.6_x86_64/llvm17_lib-17.0.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1b851977336e8c48ca985aad78b3e71d514d6eef75195da0bd1eae614678655e',
     armv7l: '1b851977336e8c48ca985aad78b3e71d514d6eef75195da0bd1eae614678655e',
       i686: 'f47a87bcc8a967588ac58f3a1cb8dd04cf99a87609c25f89b37c36e175d88935',
     x86_64: '044eda04df56f53738d5dbd22aadbc4d22d2d06e3efa0dea6bb86e1887a913b5'
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

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
