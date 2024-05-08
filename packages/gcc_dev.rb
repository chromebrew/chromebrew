require 'package'
require_relative 'gcc_build'

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  version "14.1.0-glibc#{LIBC_VERSION}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case LIBC_VERSION
  when '2.23'
    binary_sha256({
         i686: '68823c2d372559b5ba9e304529bd01f24ccf7c0a71a14824d048b2d323643257'
    })
  when '2.27', '2.35'
    binary_sha256({
      aarch64: 'f649c41a0d2fbfb5077068319d6dd8cca84b4047d409213b8f32623dff4e2bbd',
       armv7l: 'f649c41a0d2fbfb5077068319d6dd8cca84b4047d409213b8f32623dff4e2bbd',
       x86_64: 'fb235557844b33ada4de312d2f4709319ffe900c5b62a5fc4b54a06f517aa32c'
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
  depends_on 'zlibpkg' # R
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
