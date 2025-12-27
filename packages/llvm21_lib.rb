require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.7'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62cf96c644e91958f91afd6e0d1345a0aae35693ac3c16071ac02f62c2027f33',
     armv7l: '62cf96c644e91958f91afd6e0d1345a0aae35693ac3c16071ac02f62c2027f33',
       i686: '8a29d332289dd445338373ebec513ef3f8fe8fd40110f0c451ae9e5e0bb7a3e0',
     x86_64: '88f5cb28fb322da065676310f74b6d6d7989c340b6a0d7a65996a438660d2d94'
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
    abort "Update #{CREW_LLVM_VER} first.".lightred if Gem::Version.new(version.split('-').first) < Gem::Version.new(Llvm21_build.version.split('-').first)
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
