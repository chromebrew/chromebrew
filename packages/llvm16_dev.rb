require 'package'
require_relative 'llvm16_build'

class Llvm16_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm16_build.homepage
  version '16.0.6'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm16_build.version}".orange if version != Llvm16_build.version.to_s
  license Llvm16_build.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_dev16/16.0.5_armv7l/llvm_dev16-16.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_dev16/16.0.5_armv7l/llvm_dev16-16.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_dev16/16.0.5_i686/llvm_dev16-16.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_dev16/16.0.5_x86_64/llvm_dev16-16.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f4a2ccdb3366661c1ac733a317fe1853e5a5257fb7060610881ec34569cb3317',
     armv7l: 'f4a2ccdb3366661c1ac733a317fe1853e5a5257fb7060610881ec34569cb3317',
       i686: 'a14b1808ff4d03b0fd5431c86d84ddb0a1d435bef96ae0c347b623bb34aa5206',
     x86_64: 'eba6acd9fd5192ac826cdc4491cb442bb1cb3a1317368929b1c622ae58a361c9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm16_build' => :build
  depends_on 'llvm16_lib' # R
  depends_on 'ncurses' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.install
    puts 'Installing llvm16_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm16_build.filelist')
    abort 'File list for llvm16_build does not exist!'.lightred unless File.file?(@filelist_path)
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
