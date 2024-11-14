require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Llvm19_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm19_build.homepage
  version '19.1.3'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm19_build.version}".orange if version != Llvm19_build.version
  license Llvm19_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4427b305119b11e20a270636e591e314d34d12a1112a5ff8a198aaf8b4511bae',
     armv7l: '4427b305119b11e20a270636e591e314d34d12a1112a5ff8a198aaf8b4511bae',
       i686: '18f9757589faa00e3c027d1ae142660451b56c3411f7396faf57ffbc99c5ee85',
     x86_64: '0808a8775756771f87d610a7b4838b5cfad9180db9e73aa0d4be868378acb77e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm19_build' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm19_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm19_build.filelist')
    abort 'File list for llvm19_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
