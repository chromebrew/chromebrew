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
    aarch64: '9fd5462f54d63ff6131c81268f673168f277c09e3240259a860c76853fea080d',
     armv7l: '9fd5462f54d63ff6131c81268f673168f277c09e3240259a860c76853fea080d',
       i686: 'de31ba3c704cf5653cdeb41333f41332dae38b548d4552cee5b845964ed001c5',
     x86_64: '643085dce3f50b65681e21609503f4a4008edf2b4eb9d969af2de0e5acb355c7'
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
