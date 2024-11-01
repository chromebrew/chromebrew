require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Llvm19_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm19_build.homepage
  version '19.1.3'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm19_build.version}".orange if version != Llvm19_build.version
  license Llvm19_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebd5bcdfa63f8fe489dca21117b51ac22aaa0355dfc473c36321751097d78b21',
     armv7l: 'ebd5bcdfa63f8fe489dca21117b51ac22aaa0355dfc473c36321751097d78b21',
       i686: '4c465c22572a57244760759fc0090166188b478801ee95a55c74c44a7877ff5a',
     x86_64: '77c33aff8351470a71a24bf204a47c044fa8fe15e9bcd78f95edd5f3c3b31733'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libxml2' # R
  depends_on 'llvm19_build' => :build
  depends_on 'llvm19_lib' # R
  depends_on 'xzutils' # R
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
      next if filename.include?('.so') && filename.include?('libLLVM')
      next if filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
