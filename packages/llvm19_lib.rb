require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Llvm19_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm19_build.homepage
  version '19.1.0'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm19_build.version}".orange if version != Llvm19_build.version
  license Llvm19_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c9b38f8a50b1f19d7da99da99487caae9ec4a0adfb04ee38e6a8f7418f59585',
     armv7l: '9c9b38f8a50b1f19d7da99da99487caae9ec4a0adfb04ee38e6a8f7418f59585',
       i686: '846ee7b7bd00c5b020a9b04d03c44326ad71d1dc4dbfb482a78feb1b83fd2e25',
     x86_64: '37cb31611a81038f824eb9636921db1be18a7f10f868536f93a4fd87023008ff'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm19_build' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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
