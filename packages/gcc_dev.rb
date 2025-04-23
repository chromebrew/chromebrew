require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  @gcc_libc_version = if %w[2.23 2.27 2.32 2.33 2.35 2.37].any? { |i| LIBC_VERSION.include? i }
                        LIBC_VERSION
                      else
                        ARCH.eql?('i686') ? '2.23' : '2.27'
                      end
  version "15.1.0-RC-20250418-glibc#{@gcc_libc_version}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case @gcc_libc_version
  when '2.23'

  binary_sha256({
       i686: '784614d98a93fcf9ae3eb421b5ad167067fb0a244972a21c1069de6e4dc79007'
  })
  when '2.27', '2.32', '2.33', '2.35'

  binary_sha256({
    aarch64: '783fd8997e745605d2fc6f385780e1d92723cc308f591cd3c0047f443fe5b42a',
     armv7l: '783fd8997e745605d2fc6f385780e1d92723cc308f591cd3c0047f443fe5b42a',
     x86_64: '6e84bc2e3fd578bf14151e65b3c6676b778ade59e2f541aa8d0dcb2b0aa8762c'
  })
  when '2.37'
    binary_sha256({
      aarch64: 'b78b3c593c74cc1f88cfacc0c59c0312780aed0652b63366f7691dffb3c2383f',
       armv7l: 'b78b3c593c74cc1f88cfacc0c59c0312780aed0652b63366f7691dffb3c2383f',
       x86_64: '2f73cca16717175052cb2dbe47d26b2e8ca7f07c48f84b7ee78ee4efa4dda41d'
    })
  end

  depends_on 'gcc_build' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
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
