require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm20_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm20_build.homepage
  version '20.1.8'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm20_build.version}".orange if version != Llvm20_build.version
  license Llvm20_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a725bbf49734ec16fbfe3e435aa5051503189d9e3ef265e0f49589b4ac32bc8',
     armv7l: '2a725bbf49734ec16fbfe3e435aa5051503189d9e3ef265e0f49589b4ac32bc8',
       i686: '5cb400aa132e3a6e492f249e5eb1c5da49ad5a25e59b2997e172c13358383ac1',
     x86_64: 'ad2041afe2fe49e54d9ed48f4d5f55b5e1291ef69ed8643599e3f18e8a35ee5d'
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
    @filelist = File.readlines(@filelist_path, chomp: true).reject { |line| line.start_with?('#') }

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
