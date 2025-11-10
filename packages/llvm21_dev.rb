require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.5'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ba7cfb1096e79b5985722f6cb15099a4d76d005915fe52ecc83b9ccc9344fda',
     armv7l: '8ba7cfb1096e79b5985722f6cb15099a4d76d005915fe52ecc83b9ccc9344fda',
       i686: 'fd1a9897d9b21d92c967e4b327b89a162eb019dde93f95e2c4663a4c50dda2f8',
     x86_64: '22c90ce8c6adf0900cc1753b0059f800fea06e2d779c4072b330b562ffc90a99'
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

  def self.preflight
    abort "Update #{CREW_LLVM_VER} first.".lightred if Gem::Version.new(version.split('-').first) < Gem::Version.new(Llvm21_build.version.split('-').first)
  end

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
