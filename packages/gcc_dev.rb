require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  version "14.2.0-glibc#{LIBC_VERSION}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case LIBC_VERSION
  when '2.23'
    binary_sha256({
         i686: '77a2ba61cc2529d8dff15e03f10c736fb807f6ce1c112fea71d6050f5005d43a'
    })
  when '2.27', '2.32', '2.33', '2.35'
    binary_sha256({
      aarch64: '3e0d4ca3bc9488f04b22e7ea895fdd5af54b120d00b816cae0bb0c09c78c897b',
       armv7l: '3e0d4ca3bc9488f04b22e7ea895fdd5af54b120d00b816cae0bb0c09c78c897b',
       x86_64: 'd17ad49fd409e1bc1f850c4415832afac45f31cef999949aeb60b21611b66ddf'
    })
  when '2.37'
    binary_sha256({
      aarch64: '258cd5814cee743dd20f58a9eba503d9ad825123c47b4ca53ad0fa86d50ce38b',
       armv7l: '258cd5814cee743dd20f58a9eba503d9ad825123c47b4ca53ad0fa86d50ce38b',
       x86_64: 'd287e0279881675ae404ebdb4e99bcdb89297263e257e4a2a4b0b6b4e9876059'
    })
  end

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
