require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  @_ver = '0.9.6'
  version @_ver
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{@_ver_prelastdot}/libssh-#{@_ver}.tar.xz"
  source_sha256 '86bcf885bd9b80466fe0e05453c58b877df61afa8ba947a58c356d7f0fab829b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.9.6_armv7l/libssh-0.9.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.9.6_armv7l/libssh-0.9.6-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.9.6_i686/libssh-0.9.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.9.6_x86_64/libssh-0.9.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5c4a6da32f3b23488dd15e06a5eb77e191143e4d5b5a396331a429e9d5dd5cfd',
     armv7l: '5c4a6da32f3b23488dd15e06a5eb77e191143e4d5b5a396331a429e9d5dd5cfd',
       i686: '9a3d676f230262a5974fe05e7ea705c9062a5b27364655e29e2abf4158009389',
     x86_64: 'a4a261a53541349d5c9564a74f7a5d5051d33a4cbdbc06885810eb948f0d01a8'
  })

  depends_on 'libgcrypt'

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DWITH_EXAMPLES=OFF \
      -DBUILD_SHARED_LIBS=OFF \
      -DWITH_STATIC_LIB=ON \
      ../ -G Ninja"
    end
    system 'ninja -C builddir'
    Dir.chdir('builddir') do
      FileUtils.cp 'src/libssh.a', '../' if File.exist?('src/libssh.a')
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DWITH_EXAMPLES=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DWITH_STATIC_LIB=OFF \
      ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.cp 'libssh.a', CREW_DEST_LIB_PREFIX if File.exist?('libssh.a')
  end
end
