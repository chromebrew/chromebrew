require 'package'
Package.load_package("#{__dir__}/llvm22_build.rb")

class Llvm22_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm22_build.homepage
  version '22.1.0'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm22_build.version}".orange if version != Llvm22_build.version && !ENV['NESTED_CI']
  license Llvm22_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43cbd1aee5623a1088922e714e2382c321ced2e300c5d66cf83273751d6c684b',
     armv7l: '43cbd1aee5623a1088922e714e2382c321ced2e300c5d66cf83273751d6c684b',
       i686: '031ebdcdc264056e539c5c83244827d0ab46d13f3ae8b00f8908c3c00912c9a8',
     x86_64: '70fb7d1102537283f447dba29584dc538262cc3cbfa5fbe1019f3b5b46856013'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm22_build' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.preflight
    abort "Update #{CREW_LLVM_VER} first.".lightred if Gem::Version.new(version.split('-').first) < Gem::Version.new(Llvm22_build.version.split('-').first)
  end

  def self.install
    puts 'Installing llvm22_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm22_build.filelist')
    abort 'File list for llvm22_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
