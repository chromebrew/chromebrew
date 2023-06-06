require 'package'
require_relative 'gcc_build'

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything except libgcc'
  homepage Gcc_build.homepage
  version '13.1.0' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib and gcc_dev in tandem.
  puts "#{self} version differs from gcc version #{Gcc_build.version}".orange if version != Gcc_build.version.to_s
  license Gcc_build.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_dev/13.1.0_armv7l/gcc_dev-13.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_dev/13.1.0_armv7l/gcc_dev-13.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_dev/13.1.0_i686/gcc_dev-13.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_dev/13.1.0_x86_64/gcc_dev-13.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '12169c998f12d1117a90252ebdf49f3139d1a22c58474db202a86f24060d285b',
     armv7l: '12169c998f12d1117a90252ebdf49f3139d1a22c58474db202a86f24060d285b',
       i686: '072646bcb2d26baed67c80357367cadb30aef30523b6b39c2984cdf4761c0a86',
     x86_64: 'c9eb15813b74fa9393da20d38b30aab61c14079adb052e4cc7e98e73fa61a04a'
  })

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

  conflicts_ok

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next if filename.include?('.so') && filename.include?('libgcc_s')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
