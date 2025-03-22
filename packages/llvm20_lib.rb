require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm20_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm20_build.homepage
  version '20.1.1'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm20_build.version}".orange if version != Llvm20_build.version
  license Llvm20_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0b1cfc5b7ea58e59814d5e20563572dc203f3e84286d8add875effc36d841a6',
     armv7l: 'b0b1cfc5b7ea58e59814d5e20563572dc203f3e84286d8add875effc36d841a6',
       i686: '38307d662206b22a7d90ed5948f7188c604a161c6ee8ef7bd8ab34bbed49db8e',
     x86_64: '595cbd3332124365a158d62af0b1103391c153e416a74333de6fecfdb004128f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm20_build' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm20_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm20_build.filelist')
    abort 'File list for llvm20_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
