require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.2'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '623fac710268e7ff1da810b082fd031971e61a4bc30a94427ad90336a60c019f',
     armv7l: '623fac710268e7ff1da810b082fd031971e61a4bc30a94427ad90336a60c019f',
       i686: '1564e6155efa91287220f9b6b6bb67d6e624e8815f45718aab8bc9d78d146279',
     x86_64: '46e50b28ca80591be5bff1d80aa21c87ec0c83df0cc013dbd5046bd5f48448f8'
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
