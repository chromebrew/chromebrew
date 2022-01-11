require 'package'

class Libcddb < Package
  description 'Libcddb is a C library to access data on a CDDB server (freedb.org).'
  homepage 'http://libcddb.sourceforge.net/'
  version '1.3.2-1'
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/libcddb/files/libcddb/1.3.2/libcddb-1.3.2.tar.bz2'
  source_sha256 '35ce0ee1741ea38def304ddfe84a958901413aa829698357f0bee5bb8f0a223b'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --without-cdio"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
