require 'package'

class Llvm23_dev < Package
  llvm_build_obj = Package.load_package("#{__dir__}/llvm23_build.rb")
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
    aarch64: '7d6a0081915b3a837d8c1120079adb7008f17b5d74b357ace6f920ddd2db88eb',
     armv7l: '7d6a0081915b3a837d8c1120079adb7008f17b5d74b357ace6f920ddd2db88eb',
       i686: 'f073f5a5d68253e5bd1180cca4458d9484bfdca5aa848992212d5443c0290310',
     x86_64: '7b7bc44a878f9d08424ac8f48fac24e0f14aab231e1c24380de930060ea13bbb'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libedit' => :library
  depends_on 'libxml2' => :library
  depends_on 'llvm23_build' => :build
  depends_on 'llvm23_lib' # R
  depends_on 'llvm_lib' => :library
  depends_on 'tree_sitter' => :library
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
    puts 'Installing llvm23_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm23_build.filelist')
    abort 'File list for llvm23_build does not exist!'.lightred unless File.file?(@filelist_path)
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
