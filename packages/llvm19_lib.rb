require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Llvm19_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm19_build.homepage
  version '19.1.6'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm19_build.version}".orange if version != Llvm19_build.version
  license Llvm19_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8056f904019b5ab74f7e39d294bb26e3135da280d1800805d0f9ff5cce527278',
     armv7l: '8056f904019b5ab74f7e39d294bb26e3135da280d1800805d0f9ff5cce527278',
       i686: '90db4f1aaa745e5a342140231d401c0328d6d3090c7ca0d3552b30e5244bf6a8',
     x86_64: '6d38e621166dd62117c90ecc09fe52cc876d9b592435b7b2b20daa1cd691c165'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm19_build' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R
  depends_on 'llvm19_build' # R

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
