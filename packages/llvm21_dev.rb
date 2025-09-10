require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.1'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '716858a6d79e2cdcd6320970b5e4dcb20cfd7a611e235ad4b0c58ead502a7f3c',
     armv7l: '716858a6d79e2cdcd6320970b5e4dcb20cfd7a611e235ad4b0c58ead502a7f3c',
       i686: '2dd54d958418042cd7a843ee8d928c837108fff40a6a550670722f1bad252bcc',
     x86_64: 'a0388997cc0cd9439e901f08ea679218cc2c81486c258e093d69b5e5937d5adc'
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
