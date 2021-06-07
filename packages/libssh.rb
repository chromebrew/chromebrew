require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  @_ver = '0.9.5'
  version "#{@_ver}-2"
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{@_ver_prelastdot}/libssh-#{@_ver}.tar.xz"
  source_sha256 'acffef2da98e761fc1fd9c4fddde0f3af60ab44c4f5af05cd1b2d60a3fa08718'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.9.5-2_armv7l/libssh-0.9.5-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.9.5-2_armv7l/libssh-0.9.5-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.9.5-2_i686/libssh-0.9.5-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.9.5-2_x86_64/libssh-0.9.5-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fe56c352d678f004866c27bf5b4dc1d05114387f65bc07968834ddbd5ec9bb79',
     armv7l: 'fe56c352d678f004866c27bf5b4dc1d05114387f65bc07968834ddbd5ec9bb79',
       i686: 'd524f5485303306cb39720c09e9379a3e636a1f18ba68a547dd6534c762c5c12',
     x86_64: 'abb34682d2e053ff8a7ca1f2d64d45402127a3460314a0b330641715dff21704'
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
