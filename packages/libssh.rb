require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  @_ver = '0.10.3'
  version "#{@_ver}-1"
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{@_ver_prelastdot}/libssh-#{@_ver}.tar.xz"
  source_sha256 '6e889dbe4f3eecd13a452ca868ec85525ab9c39d778519a9c141b83da738c8aa'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.3-1_armv7l/libssh-0.10.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.3-1_armv7l/libssh-0.10.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.3-1_i686/libssh-0.10.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.3-1_x86_64/libssh-0.10.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd99b1ce240d1bd5b6bb01ffd779a0d3d25981afe1417110a8f7e86f425269aa7',
     armv7l: 'd99b1ce240d1bd5b6bb01ffd779a0d3d25981afe1417110a8f7e86f425269aa7',
       i686: '135303c2fbb04e1ef746326c2cd4fa82c707c52471033357deeef089dce8e770',
     x86_64: 'e30f47fa94fd694f0d6947f597c9195923d7509096f3a9a51ce099970501c913'
  })

  depends_on 'e2fsprogs'
  depends_on 'krb5'
  depends_on 'libgcrypt'
  depends_on 'py3_abimap' => :build
  depends_on 'zlibpkg'

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "mold -run cmake #{CREW_CMAKE_OPTIONS} \
      -DWITH_EXAMPLES=OFF \
      -DBUILD_SHARED_LIBS=OFF \
      ../ -G Ninja"
    end
    system 'mold -run samu -C builddir'
    Dir.chdir('builddir') do
      FileUtils.cp 'src/libssh.a', '../' if File.exist?('src/libssh.a')
      system "mold -run cmake #{CREW_CMAKE_OPTIONS} \
      -DWITH_EXAMPLES=OFF \
      -DBUILD_SHARED_LIBS=ON \
      ../ -G Ninja"
    end
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    FileUtils.cp 'libssh.a', CREW_DEST_LIB_PREFIX if File.exist?('libssh.a')
  end
end
