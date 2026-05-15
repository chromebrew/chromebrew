require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  version '16.1.0'
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, libssp, and then binutils in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd18c1aa9d6c9c00d9a181fed7aef6cf96ae4585ef00698993d53c129a903ce20',
     armv7l: 'd18c1aa9d6c9c00d9a181fed7aef6cf96ae4585ef00698993d53c129a903ce20',
       i686: 'a61ffc3138a97ce47eb984333cb4c8b6c4ed37d1ac00ade1864daa48b459d5e6',
     x86_64: '3c06fa45d968c0e56f73800f8276dfa28d4c96967ab98f155dd3f02f8a16811b'
  })

  depends_on 'gcc_build' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_fallthrough' => :library
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
