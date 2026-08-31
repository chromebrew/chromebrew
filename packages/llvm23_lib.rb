require 'package'

class Llvm23_lib < Package
  @llvm_build_obj = Package.load_package("#{__dir__}/#{ancestors[0].to_s.split('::')[1].downcase.split('_').first}_build.rb")
  @default_llvm_build_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")
  description 'LibLLVM and llvm-strip'
  homepage @llvm_build_obj.homepage
  version @llvm_build_obj.version
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{@default_llvm_build_obj.version}".orange if version != @default_llvm_build_obj.version && !ENV['NESTED_CI']
  license @llvm_build_obj.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77b88107539f24fb0d1784fc0f0b736d83d98ad7130e2d4ce6910746abfa3801',
     armv7l: '77b88107539f24fb0d1784fc0f0b736d83d98ad7130e2d4ce6910746abfa3801',
       i686: '8d075d505306bc71c49f5c498db1897a96d98ff0527e6f90abd31283715938aa',
     x86_64: '9e68dbce3d1ea729e47b4516879db533ccc4232073630bf0e6ecfcde6f25f0bf'
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
    abort "Update #{ancestors[0].to_s.split('::')[1].downcase.split('_').first}_build first.".lightred if Gem::Version.new(version) < Gem::Version.new(@default_llvm_build_obj.version.split('-').first)
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
