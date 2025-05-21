require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  version '15.1.0' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd4288f9c1e89f9bfc29aa6a932f2b33a8e769603bcda4a50debad0e0b362acb',
     armv7l: 'bd4288f9c1e89f9bfc29aa6a932f2b33a8e769603bcda4a50debad0e0b362acb',
       i686: '7b44a7428fe19918c9e2cb6a85a71b127b8c11f156e0aec67bff5e6a334202fe',
     x86_64: 'e140bce8d1f3a4c0c143d5edff169dc1b2ca355bf6a2771cd6cbf0b64939a994'
  })

  depends_on 'gcc_build' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'isl' # R
  depends_on 'libssp' # L
  depends_on 'mpc' # R
  depends_on 'mpfr' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next if filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
