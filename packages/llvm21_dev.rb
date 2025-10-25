require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.4'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec5f24c077de009539d0343c9e2b758a45930e3255f2b56d6a148bf4816202f0',
     armv7l: 'ec5f24c077de009539d0343c9e2b758a45930e3255f2b56d6a148bf4816202f0',
       i686: '7b3781fe1e71455f45afd27a1465dd6f25235f2bc239704b29df4604c7011bb4',
     x86_64: 'be68f9cea6f0d3c47005e860eaca54f4fc3849a4222d6813ea6b7f88e65e558e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libxml2' # R
  depends_on 'llvm21_build' => :build
  depends_on 'llvm_lib' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm21_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm21_build.filelist')
    abort 'File list for llvm21_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next if filename.include?('.so') && filename.include?('libLLVM')
      next if filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
