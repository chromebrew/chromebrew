require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  version '16.2.0'
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, libssp, and then binutils in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ddc5fd06026cff124e997fb0d63de5263e8b64349a4e4dc58656c2a73f99771',
     armv7l: '9ddc5fd06026cff124e997fb0d63de5263e8b64349a4e4dc58656c2a73f99771',
       i686: 'f250cfb2c07128d7d24860e3294f248c5ae9301859c962743255d4279c275736',
     x86_64: '1d9dc9a4a2e9de58ba46381f30534924f03267cf9e85cd6ee3e92fd76dbe68e9'
  })

  depends_on 'gcc_build' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'isl' => :library
  depends_on 'libssp' => :logical
  depends_on 'mpc' => :library
  depends_on 'mpfr' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next if filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
