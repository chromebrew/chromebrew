require 'package'

class Libcddb < Package
  description 'Libcddb is a C library to access data on a CDDB server (freedb.org).'
  homepage 'http://libcddb.sourceforge.net/'
  version '1.3.2-1'
  compatibility 'all'
  license 'LGPL-2'
  source_url 'https://sourceforge.net/projects/libcddb/files/libcddb/1.3.2/libcddb-1.3.2.tar.bz2'
  source_sha256 '35ce0ee1741ea38def304ddfe84a958901413aa829698357f0bee5bb8f0a223b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcddb/1.3.2-1_armv7l/libcddb-1.3.2-1-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcddb/1.3.2-1_armv7l/libcddb-1.3.2-1-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcddb/1.3.2-1_i686/libcddb-1.3.2-1-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcddb/1.3.2-1_x86_64/libcddb-1.3.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '20b533d43dc7f61a9a1c72c1a8343688dbf4b9e0353788ee80f43760636ebea3',
      armv7l: '20b533d43dc7f61a9a1c72c1a8343688dbf4b9e0353788ee80f43760636ebea3',
        i686: '99667ddb37115fe554a88104f10c5690a23fe55bc40468c878b7c437984ea313',
      x86_64: '5106dc4d2ca03f158baa7f187df0f75ab19c5cc480f0ba85ae6d1ccfc8af71ef'
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --without-cdio"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
