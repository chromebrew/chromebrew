require 'package'
Package.load_package("#{__dir__}/llvm18_build.rb")

class Llvm18_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm18_build.homepage
  version '18.1.8'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license Llvm18_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f0278019b26039b5da4f747686fd876749219657587ccca03c72582a2b6ef1e',
     armv7l: '4f0278019b26039b5da4f747686fd876749219657587ccca03c72582a2b6ef1e',
       i686: '76d40497c64c7a4a30baf64caa110e663604b5f3911cc222fc5a2e6226ad319d',
     x86_64: '9387b70a5bb49555450424024ffc3a0cfd81cf6c74c95568d8860c7ee5be0f6a'
  })

  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm18_build' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'ncurses' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm18_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm18_build.filelist')
    abort 'File list for llvm18_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).reject { |line| line.start_with?('#') }

    @filelist.each do |filename|
      next if filename.include?('.so') && filename.include?('libLLVM')
      next if filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
