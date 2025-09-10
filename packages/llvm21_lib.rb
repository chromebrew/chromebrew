require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.1'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e261765c9f87fe5a69292b1fbabcf4015173885fc8eb9a0bab101855a171ba7e',
     armv7l: 'e261765c9f87fe5a69292b1fbabcf4015173885fc8eb9a0bab101855a171ba7e',
       i686: 'e03d048b8b197bae9a5dcfe8c2f6c4b555854350c1233b763fa5aac1ff9e3add',
     x86_64: '3715da6c27bed62feb93df7da70ca41b1211108bc3c696615d8fa76c335ec252'
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
