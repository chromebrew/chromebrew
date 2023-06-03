require 'package'
require_relative 'llvm_build'

class Llvm_libs < Package
  description 'LLVM Libraries'
  homepage Llvm_build.homepage
  version '16.0.5'
  # When upgrading llvm, be sure to upgrade llvm_libs in tandem.
  puts "#{self} version differs from llvm version #{Llvm_build.version}".orange if version != Llvm_build.version.to_s
  license Llvm_build.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_libs/16.0.5_armv7l/llvm_libs-16.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_libs/16.0.5_armv7l/llvm_libs-16.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_libs/16.0.5_i686/llvm_libs-16.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_libs/16.0.5_x86_64/llvm_libs-16.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9761adb20f321950ef7c5040d3c57cdc9d079a0a73019a92a6cf27e2356719a8',
     armv7l: '9761adb20f321950ef7c5040d3c57cdc9d079a0a73019a92a6cf27e2356719a8',
       i686: '286cba57561e4c60084981f6019636489c3e59bd861ec92d7591bbb379c5bf3a',
     x86_64: '571392d60f172f60bbfb029af2e3e868b3fed1cce2c965955b0711468740dfa1'
  })

  depends_on 'llvm_build' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  conflicts_ok

  def self.install
    puts 'Installing llvm_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm_build.filelist')
    abort 'File list for llvm_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?(CREW_LIB_PREFIX) && filename.include?('.so') && filename.include?('libLLVM')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
