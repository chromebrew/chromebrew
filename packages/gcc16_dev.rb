require 'package'

class Gcc16_dev < Package
  gcc_build_obj = Package.load_package("#{__dir__}/gcc16_build.rb")
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage gcc_build_obj.homepage
  version gcc_build_obj.version
  license gcc_build_obj.license
  # For major version GCC changes, be sure to update CREW_GCC_VER in
  # lib/const.rb install.sh, and rebuild binutils.
  # Also rebuild #{CREW_GCC_VER}_lib, #{CREW_GCC_VER}_dev, and
  # libssp whenever #{CREW_GCC_VER}_build is rebuilt.
  puts "#{self} version (#{version}) differs from gcc version #{gcc_build_obj.version}".orange if version != gcc_build_obj.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '501eb1ff8c303fcbcc2b6582f28f355aae486ee6a32282a07b3b6d9b25d172d3',
     armv7l: '501eb1ff8c303fcbcc2b6582f28f355aae486ee6a32282a07b3b6d9b25d172d3',
       i686: 'c6a4770caddc356f3a192443df6e044a3f1b812bd4af0e7558c640537d7aea7a',
     x86_64: '19380101c0dce5822aec6f9b81e16d8f2c2550a78440351466d680cf2980cddf'
  })

  depends_on 'gcc16_build' => :build
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

  conflicts_ok # Conflicts with gcc_dev.
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing gcc_build_obj to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc16_build.filelist')
    abort 'File list for gcc_build_obj does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next if filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
