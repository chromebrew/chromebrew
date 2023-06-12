require 'package'
require_relative 'llvm_build16'

class Llvm_lib16 < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm_build16.homepage
  version '16.0.5'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm_build16.version}".orange if version != Llvm_build16.version.to_s
  license Llvm_build16.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_lib16/16.0.5_armv7l/llvm_lib16-16.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_lib16/16.0.5_armv7l/llvm_lib16-16.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_lib16/16.0.5_i686/llvm_lib16-16.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_lib16/16.0.5_x86_64/llvm_lib16-16.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ac8284a2e2f2c21b330d8f3ebfbd9e93fb023710ce44e702df97d32117d76b60',
     armv7l: 'ac8284a2e2f2c21b330d8f3ebfbd9e93fb023710ce44e702df97d32117d76b60',
       i686: '96143e8c99aec50b417bfa31b8b34adb645def08b9957cfa7417fcb1e56d0073',
     x86_64: '5cde03339bf1b972d926cfb81daa825b5814f387ba02fc729b31b95818b122e2'
  })

  depends_on 'llvm_build16' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.install
    puts 'Installing llvm_build16 to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm_build16.filelist')
    abort 'File list for llvm_build16 does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
