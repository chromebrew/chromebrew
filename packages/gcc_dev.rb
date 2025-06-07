require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  version '15.1.0-69eb171' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0cdc5b4a9a187983b0342d5f741fc785207eeecca819a1c050e119ea4b4f230',
     armv7l: 'e0cdc5b4a9a187983b0342d5f741fc785207eeecca819a1c050e119ea4b4f230',
       i686: '4cc26b27d18e06bd415723d04f9033893232e0cdb640028ce87172e1f5fbe06e',
     x86_64: 'e89dcaeac4f71b50a5066e07dbd4544e011fb6874bfdf286338ee91fa1a5271a'
  })

  binary_sha256({
    aarch64: 'e0cdc5b4a9a187983b0342d5f741fc785207eeecca819a1c050e119ea4b4f230',
     armv7l: 'e0cdc5b4a9a187983b0342d5f741fc785207eeecca819a1c050e119ea4b4f230',
       i686: '4cc26b27d18e06bd415723d04f9033893232e0cdb640028ce87172e1f5fbe06e',
     x86_64: 'e89dcaeac4f71b50a5066e07dbd4544e011fb6874bfdf286338ee91fa1a5271a'
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
