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
    aarch64: 'ba6f1b3472c13de23a70814c4f155d5f593c76cd2d0b953b9e260f7a0f71da31',
     armv7l: 'ba6f1b3472c13de23a70814c4f155d5f593c76cd2d0b953b9e260f7a0f71da31',
       i686: '3b34a6f6be98f8abdde4e22f94ed27c491154b12fe6f983e745dfdc4dd396446',
     x86_64: 'e9a3c6bb7bee0329fd56c2edc0db3512b004bfefa81ccb4dbb53519a62672202'
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
