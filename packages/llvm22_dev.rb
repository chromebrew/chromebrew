require 'package'

class Llvm22_dev < Package
  llvm_build_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage llvm_build_obj.homepage
  version llvm_build_obj.version
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{llvm_build_obj.version}".orange if version != llvm_build_obj.version && !ENV['NESTED_CI']
  license llvm_build_obj.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7712dbdcee64e04dbec1590730e941a7a711cbb5adb45bad7d15317dce8d85c1',
     armv7l: '7712dbdcee64e04dbec1590730e941a7a711cbb5adb45bad7d15317dce8d85c1',
       i686: 'ec8ae338c7aa2395f989703b0571438c38f52b2b3594181909e584da29a70cdc',
     x86_64: '86abf404917995ed5d640a70ad4a4ba302fa30da52f043b71498910246483636'
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
    llvm_build_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")
    abort "Update #{CREW_LLVM_VER}_build first.".lightred if Gem::Version.new(version) < Gem::Version.new(llvm_build_obj.version.split('-').first)
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
