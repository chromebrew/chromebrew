require 'package'

class Arpack_ng < Package
  description 'Collection of Fortran77 subroutines designed to solve large scale eigenvalue problems.'
  homepage 'https://github.com/opencollab/arpack-ng'
  version '3.7.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/opencollab/arpack-ng/archive/3.7.0.tar.gz'
  source_sha256 '972e3fc3cd0b9d6b5a737c9bf6fd07515c0d6549319d4ffb06970e64fa3cc2d6'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/arpack_ng/3.7.0_armv7l/arpack_ng-3.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/arpack_ng/3.7.0_armv7l/arpack_ng-3.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/arpack_ng/3.7.0_i686/arpack_ng-3.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/arpack_ng/3.7.0_x86_64/arpack_ng-3.7.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8ac867cd31ef8c507039105de1e6467807c30a75f1752ab43650d82348b558d0',
     armv7l: '8ac867cd31ef8c507039105de1e6467807c30a75f1752ab43650d82348b558d0',
       i686: '8c2096851e7868c456220480b315d8ba84b5c188d8bf193cf8ce8abea6b20eb4',
     x86_64: '83b1d11cbc66d977dc2287f8273a39527bd33c302b81baaa84172c110b6aeed1'
  })

  depends_on 'lapack'
  depends_on 'openblas'
  depends_on 'openmpi'
  depends_on 'ld_default' => :build

  def self.patch
    # Fix Unknown CMake command "check_symbol_exists".
    # See https://techoverflow.net/2019/06/20/how-to-fix-unknown-cmake-command-check_symbol_exists/.
    system "sed -i '1iinclude(CheckSymbolExists)' CMakeLists.txt"
  end

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      suffix = ''
      interface = 'OFF'
      if ARCH == 'x86_64'
        suffix = '64'
        interface = 'ON'
      end
      # Use the gold linker.
      old_ld = `ld_default g`.chomp
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DBLAS_LIBRARIES=#{CREW_LIB_PREFIX}/libopenblas.so",
             "-DINTERFACE64=#{interface}",
             "-DLIBSUFFIX=#{suffix}",
             '-DBUILD_SHARED_LIBS=ON',
             '-DEXAMPLES=ON',
             '-DICB=ON',
             '-DMPI=ON',
             '..'
      system 'make'
      system 'ld_default', old_ld
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
