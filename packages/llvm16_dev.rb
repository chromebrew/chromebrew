require 'package'
require_relative 'llvm16_build'

class Llvm16_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm16_build.homepage
  version '16.0.6'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm16_build.version}".orange if version != Llvm16_build.version
  license Llvm16_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm16_dev/16.0.6_armv7l/llvm16_dev-16.0.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm16_dev/16.0.6_armv7l/llvm16_dev-16.0.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm16_dev/16.0.6_i686/llvm16_dev-16.0.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm16_dev/16.0.6_x86_64/llvm16_dev-16.0.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ec2e7ecd345e7d39e8e6e0de780b4770abe3f839d1ddaed51c16e86d97b7a024',
     armv7l: 'ec2e7ecd345e7d39e8e6e0de780b4770abe3f839d1ddaed51c16e86d97b7a024',
       i686: 'e8d83c2237656c00ff57c562c25901004a2e88a3015e6bf40954afad4172c05b',
     x86_64: '427c152245ddd14db63e2b9d41038b1c0cc37e2c63ab758a5d04d654e066b69e'
  })

  depends_on 'gcc_dev' # R
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

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
