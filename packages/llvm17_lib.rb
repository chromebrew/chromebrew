require 'package'
require_relative 'llvm17_build'

class Llvm17_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm17_build.homepage
  version '17.0.2'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm17_build.version}".orange if version != Llvm17_build.version.to_s
  license Llvm17_build.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.2_armv7l/llvm17_lib-17.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.2_armv7l/llvm17_lib-17.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.2_i686/llvm17_lib-17.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_lib/17.0.2_x86_64/llvm17_lib-17.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ceb06bd5ba59d5153638259de9e3f6baaa7ef05f55857988078837cd8fa0d681',
     armv7l: 'ceb06bd5ba59d5153638259de9e3f6baaa7ef05f55857988078837cd8fa0d681',
       i686: 'f58034a401ae0d0d939946b92f2034e8e9b837376b3ab92acbdd9671d413a2aa',
     x86_64: 'af6d4a6120d03b1db578ad77a1bb9c97353bcc67c0b5ff585ce83a65fe02c99b'
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
