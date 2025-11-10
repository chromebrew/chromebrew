require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.4'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '836c8558c8d3eea7fd1b4f3aeaeefd2765e19e5898927636122242aadc80baeb',
     armv7l: '836c8558c8d3eea7fd1b4f3aeaeefd2765e19e5898927636122242aadc80baeb',
       i686: 'a8212a54fd8ab798190280ab2c14fa60e389f858cf2b6d51becdd0a641a39d83',
     x86_64: '5198af84e128f2d4e3b5378778418d19b457950b94de35da413e521e7b558675'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm21_build' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.preflight
    abort "Update #{CREW_LLVM_VER} first.".lightred if Gem::Version.new(version.split('-').first) < Gem::Version.new(Llvm21_build.split('-').first)
  end

  def self.install
    puts 'Installing llvm21_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm21_build.filelist')
    abort 'File list for llvm21_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
