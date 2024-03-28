require 'package'
require_relative 'llvm18_build'

class Llvm18_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm18_build.homepage
  version '18.1.2'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license Llvm18_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b2dcb7102ff12bcf1b412665a6d6377efcddc6d240091344df58693524bfe09',
     armv7l: '6b2dcb7102ff12bcf1b412665a6d6377efcddc6d240091344df58693524bfe09',
       i686: 'bd5d0d431f79c5986bf319f6c88faa3073c2bc361cd1aa1e399d0a1a71c5f06e',
     x86_64: 'ff206fd8cc93fe99c5be427b310aed32ed2b283d3704ff1dd052b20e21335175'
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
