require 'package'
require_relative 'gcc_build'

class Gcc_dev < Package
  description 'The GNU Compiler Collection: Everything (excepting libraries aside from libgccjit)'
  homepage Gcc_build.homepage
  version '13.1.0-1' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version differs from gcc version #{Gcc_build.version}".orange if version.to_s.gsub(/-.*/, '') != Gcc_build.version.to_s
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_dev/13.1.0-1_armv7l/gcc_dev-13.1.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_dev/13.1.0-1_armv7l/gcc_dev-13.1.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_dev/13.1.0-1_i686/gcc_dev-13.1.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_dev/13.1.0-1_x86_64/gcc_dev-13.1.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ec00172ae8c82f8288f612eb3f904b69f8336aa3c9a624a78e103926e1cfea91',
     armv7l: 'ec00172ae8c82f8288f612eb3f904b69f8336aa3c9a624a78e103926e1cfea91',
       i686: '44f3bb02fc9c390159be9c0524d93e980eddc97a3e9793ee57a0dc7c1545f61e',
     x86_64: '9a9e860071fef3fade59033428e54fec7c469d8094fb5dacc738d80045304f12'
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

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next if filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
