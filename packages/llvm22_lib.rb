require 'package'

class Llvm22_lib < Package
  llvm_build_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")
  description 'LibLLVM and llvm-strip'
  homepage llvm_build_obj.homepage
  version llvm_build_obj.version
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{llvm_build_obj.version}".orange if version != llvm_build_obj.version && !ENV['NESTED_CI']
  license llvm_build_obj.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '896b569da3380941cc156a5ea9fea0d51fb266870598ae1a3c41f5ad375b7001',
     armv7l: '896b569da3380941cc156a5ea9fea0d51fb266870598ae1a3c41f5ad375b7001',
       i686: 'fa4fa09f25d766239103afb90a18aa8150fe7747cbc74bb6f10859d40c061331',
     x86_64: '310ce39dcb141027e991597553a4c6d04d8cda01f0763a2bcb29124943274ecc'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libedit' => :library
  depends_on 'libffi' => :library
  depends_on 'libxml2' => :library
  depends_on 'llvm22_build' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.preflight
    llvm_build_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")
    abort "Update #{CREW_LLVM_VER} first.".lightred if Gem::Version.new(version) < Gem::Version.new(llvm_build_obj.version.split('-').first)
  end

  def self.install
    puts 'Installing llvm22_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm22_build.filelist')
    abort 'File list for llvm22_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
