require 'package'

class Llvm23_lib < Package
  llvm_build_obj = Package.load_package("#{__dir__}/llvm23_build.rb")
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
    aarch64: 'b753e73d4fab422e9d017522764a8f9b61e7fdb5b73067a960f683d9dfffc2cd',
     armv7l: 'b753e73d4fab422e9d017522764a8f9b61e7fdb5b73067a960f683d9dfffc2cd',
       i686: '30848d6f29b10641bf9f91427fe99efa9ff6b451425dc920c3dc1c1c587fd5e0',
     x86_64: '7730efa11902e3a85999aef1e0c15cec15225c0bf53a55bedb0cf62120fa17b2'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libedit' => :library
  depends_on 'libffi' => :library
  depends_on 'libxml2' => :library
  depends_on 'llvm23_build' => :build
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
    puts 'Installing llvm23_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm23_build.filelist')
    abort 'File list for llvm23_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
