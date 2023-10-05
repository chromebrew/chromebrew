require 'package'
require_relative 'llvm17_build'

class Llvm17_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm17_build.homepage
  version '17.0.2'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm17_build.version}".orange if version != Llvm17_build.version.to_s
  license Llvm17_build.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_dev/17.0.2_armv7l/llvm17_dev-17.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_dev/17.0.2_armv7l/llvm17_dev-17.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_dev/17.0.2_i686/llvm17_dev-17.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm17_dev/17.0.2_x86_64/llvm17_dev-17.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '261db2294118fc01e29a8c6d39578342c21d87587460625409932da4f450ce3e',
     armv7l: '261db2294118fc01e29a8c6d39578342c21d87587460625409932da4f450ce3e',
       i686: 'b7c0408746a58623015ee6f80d0aa1f01d5d7a1161c344c1e1455e2523300c1c',
     x86_64: 'c34782d68d4f160d145442de1df9a782a440ddbee68f1411415fbfe7272a8cbf'
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
