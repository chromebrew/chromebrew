require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  @_ver = '0.10.3'
  version @_ver
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{@_ver_prelastdot}/libssh-#{@_ver}.tar.xz"
  source_sha256 '6e889dbe4f3eecd13a452ca868ec85525ab9c39d778519a9c141b83da738c8aa'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.3_armv7l/libssh-0.10.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.3_armv7l/libssh-0.10.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.3_i686/libssh-0.10.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.3_x86_64/libssh-0.10.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6d9677de1be1914cbfa478c80b25101304ead4f467d5e8970644a53be7e287d1',
     armv7l: '6d9677de1be1914cbfa478c80b25101304ead4f467d5e8970644a53be7e287d1',
       i686: 'fe25cd27845a0b9c1699ffc1c9cd118744d839801ab36152e492e074f58ee6e0',
     x86_64: 'bfed4aeabbf90f40f8a369bba7a208e89c726f991af787d4c54ed51a593685e1'
  })

  depends_on 'libgcrypt'

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
