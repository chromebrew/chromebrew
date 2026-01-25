require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.8'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version && !ENV['NESTED_CI']
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '48e63c1ac0463d33962e3ea3be7988ea10d92f79aed91604346e81092ea5fdce',
     armv7l: '48e63c1ac0463d33962e3ea3be7988ea10d92f79aed91604346e81092ea5fdce',
       i686: 'fb993ceb76a87174561f66854f4283d1ba883b83294cd324a0e5805be3172209',
     x86_64: 'abe59f97a1ca6a4b6e081fa8a566976192f444fb5f15d55e632b070cbe55f9c3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libxml2' # R
  depends_on 'llvm21_build' => :build
  depends_on 'llvm_lib' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.preflight
    abort "Update #{CREW_LLVM_VER}_build first.".lightred if Gem::Version.new(version.split('-').first) < Gem::Version.new(Llvm21_build.version.split('-').first)
    llvm_lib_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_dev.rb")
    abort "Update  #{CREW_LLVM_VER}_lib first.".lightred if Gem::Version.new(version.split('-').first) > Gem::Version.new(llvm_lib_obj.version.split('-').first)
  end

  def self.install
    puts 'Installing llvm21_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm21_build.filelist')
    abort 'File list for llvm21_build does not exist!'.lightred unless File.file?(@filelist_path)
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
