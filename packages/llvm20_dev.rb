require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm20_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm20_build.homepage
  version '20.1.2'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm20_build.version}".orange if version != Llvm20_build.version
  license Llvm20_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7abcef57f7b8170b555206ffc967124906fe52625e16f5ebd56f100a201a656d',
     armv7l: '7abcef57f7b8170b555206ffc967124906fe52625e16f5ebd56f100a201a656d',
       i686: '65c19068d708ceffe7498f21c3e5a3b2186d97c48c0ab76c8a8f1c7d08ccd369',
     x86_64: 'e5bf7883da1c7945a3b935e7be9ed6b17e35c96a71ff230a7e95de29a2791745'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libxml2' # R
  depends_on 'llvm20_build' => :build
  depends_on 'llvm20_lib' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm20_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm20_build.filelist')
    abort 'File list for llvm20_build does not exist!'.lightred unless File.file?(@filelist_path)
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
