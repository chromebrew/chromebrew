require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm20_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm20_build.homepage
  version '20.1.8'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm20_build.version}".orange if version != Llvm20_build.version
  license Llvm20_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc8e890e0a163678211db1b748b017a015bdf0dd54fffa60c3456e54eaee62d2',
     armv7l: 'cc8e890e0a163678211db1b748b017a015bdf0dd54fffa60c3456e54eaee62d2',
       i686: '9f4ca58c6774e07eb4ecbf5d43e37ffa7dd76b65f714e3b48d5dd89eb20e1ec9',
     x86_64: 'cef06d697c80ea569a18906209619321dd140586489bb980e8517a2ad90ed0b8'
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
