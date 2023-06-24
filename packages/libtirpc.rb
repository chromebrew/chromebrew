require 'package'

class Libtirpc < Package
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc'
  version '1.3.3'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://downloads.sourceforge.net/project/libtirpc/libtirpc/#{version}/libtirpc-#{version}.tar.bz2"
  source_sha256 '6474e98851d9f6f33871957ddee9714fdcd9d8a5ee9abb5a98d63ea2e60e12f3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtirpc/1.3.3_armv7l/libtirpc-1.3.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtirpc/1.3.3_armv7l/libtirpc-1.3.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtirpc/1.3.3_i686/libtirpc-1.3.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtirpc/1.3.3_x86_64/libtirpc-1.3.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '35c1c157bcddb9807781d1a6ccd8d1b3499f06fda5b3d6789c60f2b54000fbd2',
     armv7l: '35c1c157bcddb9807781d1a6ccd8d1b3499f06fda5b3d6789c60f2b54000fbd2',
       i686: '7d8e3e54442fa216539c32e024d5d4aefa203c042ff9081f34690b98cb714849',
     x86_64: '05420165d33ce9802715424596c55fa0f32e71c4662fa03253b889ebcf7deade'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
