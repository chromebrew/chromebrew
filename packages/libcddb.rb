require 'package'

class Libcddb < Package
  description 'Libcddb is a C library to access data on a CDDB server (freedb.org).'
  homepage 'http://libcddb.sourceforge.net/'
  version '1.3.2-2'
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/libcddb/files/libcddb/1.3.2/libcddb-1.3.2.tar.bz2'
  source_sha256 '35ce0ee1741ea38def304ddfe84a958901413aa829698357f0bee5bb8f0a223b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcddb/1.3.2-2_armv7l/libcddb-1.3.2-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcddb/1.3.2-2_armv7l/libcddb-1.3.2-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcddb/1.3.2-2_i686/libcddb-1.3.2-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcddb/1.3.2-2_x86_64/libcddb-1.3.2-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '509230e87045ad19ebe5d807cc2ab6cc28759d5a8bec9c211dd0d71825b23cc6',
     armv7l: '509230e87045ad19ebe5d807cc2ab6cc28759d5a8bec9c211dd0d71825b23cc6',
       i686: '9a270eee0aadee941543741d495ce49ddc073baebcb55273b2eb40f5e1d08baa',
     x86_64: 'b99165bbe3988b2f68dfc716a8a4f7deac042e2def97f9df35ae5eb83a3cb6af'
  })

  depends_on 'libcdio'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    downloader 'https://sources.debian.org/data/main/libc/libcddb/1.3.2-7/debian/patches/0001-Switch-default-server-to-gnudb.org.patch',
               '3ee8610efa71322adb9095405da11b56386ac2c5825f976a84410c6270e59149'
    system 'patch -Np1 -i 0001-Switch-default-server-to-gnudb.org.patch'
    downloader 'https://sources.debian.org/data/main/libc/libcddb/1.3.2-7/debian/patches/0002-Disable-use-SIGALRM-for-DNS-lookup-timeout.patch',
               'cba6d6008b569e59b381623642c4fdde0fe8177d0063238b22a367e389cbdeb5'
    system 'patch -Np1 -i 0002-Disable-use-SIGALRM-for-DNS-lookup-timeout.patch'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
