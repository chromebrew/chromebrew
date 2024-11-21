require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Llvm19_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm19_build.homepage
  version '19.1.4'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm19_build.version}".orange if version != Llvm19_build.version
  license Llvm19_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '98e6e554beaebddfb2e845655bc115e92cb38826e3bbbe365ca6716a41cbbb49',
     armv7l: '98e6e554beaebddfb2e845655bc115e92cb38826e3bbbe365ca6716a41cbbb49',
       i686: 'f6d542f8aea68738dc38aa90f16fdc6acae70d09c20007181dfc8356f4fbbbe4',
     x86_64: '1feea8a12de4c9278471852a3f2509078c17f8a3406c68d73f835d97ef7fe44e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm19_build' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm19_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm19_build.filelist')
    abort 'File list for llvm19_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
