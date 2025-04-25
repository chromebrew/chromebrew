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
  version "15.1.0-glibc#{@gcc_libc_version}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case @gcc_libc_version
  when '2.23'

    binary_sha256({
       i686: 'b00b432593350b255d882814e94d1d1086e23de91e2216c4b4008b8477cdf73a'
  })
  when '2.27', '2.32', '2.33', '2.35', '2.37'

    binary_sha256({
    aarch64: 'f3e4b282dc94ec6982b766898436294121156c2174e4263cb7e94f5fbf704ceb',
     armv7l: 'f3e4b282dc94ec6982b766898436294121156c2174e4263cb7e94f5fbf704ceb',
     x86_64: '5f020332c8af5e77601fb0f9fb89f844ac31e8682a4e6ec082922447a4f9358c'
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
