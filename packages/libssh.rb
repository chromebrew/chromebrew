require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.10.4'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{version.rpartition('.')[0]}/libssh-#{version}.tar.xz"
  source_sha256 '07392c54ab61476288d1c1f0a7c557b50211797ad00c34c3af2bbc4dbc4bd97d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.4_armv7l/libssh-0.10.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.4_armv7l/libssh-0.10.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.4_i686/libssh-0.10.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libssh/0.10.4_x86_64/libssh-0.10.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '98672786020015c554b39a7b17f638793d7849c59927b1a9e183d6597d8f2abf',
     armv7l: '98672786020015c554b39a7b17f638793d7849c59927b1a9e183d6597d8f2abf',
       i686: '3ec59d6b418e0c461ad1b2eab9c8df4feee538132179a7cd5f4dea29ea29f127',
     x86_64: '9310e650799e8a08431b5064fad373818787f4fab6bb98d7f95010f350ba2ba8'
  })

  depends_on 'e2fsprogs'
  depends_on 'krb5'
  depends_on 'libgcrypt'
  depends_on 'py3_abimap' => :build
  depends_on 'zlibpkg'
  depends_on 'glibc' # R
  depends_on 'openssl' # R

  def self.build
    system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} -G Ninja \
    -DWITH_EXAMPLES=OFF \
    -DBUILD_SHARED_LIBS=ON"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
