require 'package'
require_relative 'llvm17_build'

class Llvm17_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm17_build.homepage
  version '17.0.4'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm17_build.version}".orange if version != Llvm17_build.version
  license Llvm17_build.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_dev/17.0.4_armv7l/llvm17_dev-17.0.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_dev/17.0.4_armv7l/llvm17_dev-17.0.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_dev/17.0.4_i686/llvm17_dev-17.0.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_dev/17.0.4_x86_64/llvm17_dev-17.0.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '77a451bb4e0f5f9f48d0d808876f9547bc57ce8ab649bae397dde8166ebbcafa',
     armv7l: '77a451bb4e0f5f9f48d0d808876f9547bc57ce8ab649bae397dde8166ebbcafa',
       i686: 'acef66f93e0f3104e7adb49d7fb08b3e26601a7ed850c81d922bbee792e3fb41',
     x86_64: '64e267f7687bb83dfbe58ee93f2db0f201eb0b702f10786f0fb896bb22bd05c4'
  })

  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm17_build' => :build
  depends_on 'llvm17_lib' # R
  depends_on 'ncurses' # R
  depends_on 'xzutils' # R
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
      if filename.include?('.so') && filename.include?('libLLVM')
        next
      elsif filename.include?('llvm-strip')
        next
      end

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
