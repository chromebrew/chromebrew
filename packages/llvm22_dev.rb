require 'package'
Package.load_package("#{__dir__}/llvm22_build.rb")

class Llvm22_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm22_build.homepage
  version '22.1.6'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm22_build.version}".orange if version != Llvm22_build.version && !ENV['NESTED_CI']
  license Llvm22_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b26db81c5fd6104e2c696e454ff3ae79c1b5fd8ed39f264a50a108b890e6cf5f',
     armv7l: 'b26db81c5fd6104e2c696e454ff3ae79c1b5fd8ed39f264a50a108b890e6cf5f',
       i686: 'f960850f4382f53ba400031f36b101871cefc263249e696e92ab79012d30f2e9',
     x86_64: '80f7518c71d2c2fcc1fe2e1d5270cdce879f96861041b7dd61cbab8d0744493a'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libedit' => :library
  depends_on 'libxml2' => :library
  depends_on 'llvm22_build' => :build
  depends_on 'llvm22_lib' # R
  depends_on 'llvm_lib' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :executable

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.preflight
    abort "Update #{CREW_LLVM_VER}_build first.".lightred if Gem::Version.new(version) < Gem::Version.new(Llvm22_build.version.split('-').first)
    llvm_lib_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_dev.rb")
    abort "Update  #{CREW_LLVM_VER}_lib first.".lightred if Gem::Version.new(version) > Gem::Version.new(llvm_lib_obj.version.split('-').first)
  end

  def self.install
    puts 'Installing llvm22_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm22_build.filelist')
    abort 'File list for llvm22_build does not exist!'.lightred unless File.file?(@filelist_path)
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
