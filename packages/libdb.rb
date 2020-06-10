require 'package'

class Libdb < Package
  description 'Berkeley DB is a family of embedded key-value database libraries providing scalable high-performance data management services to applications.'
  homepage 'http://www.oracle.com/technetwork/database/database-technologies/berkeleydb/overview/index.html'
  version '6.2.32'
  compatibility 'all'
  source_url 'https://download.oracle.com/berkeley-db/db-6.2.32.tar.gz'
  source_sha256 'a9c5e2b004a5777aa03510cfe5cd766a4a3b777713406b02809c17c8e0e7a8fb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdb-6.2.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdb-6.2.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdb-6.2.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdb-6.2.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'af75254a46b10c045b118c915e3b4021bd7a0158cb8069061ae82a715a732e10',
     armv7l: 'af75254a46b10c045b118c915e3b4021bd7a0158cb8069061ae82a715a732e10',
       i686: '0229c9ae467fd512120034336b24af89e7f8a58d8f7eaca09c9cccee8916844b',
     x86_64: '507cc3f213d01122b5214302b7433c9a9926b0f9f57551aeee1f9fcca8c90d2e',
  })

  def self.build
    Dir.chdir 'build_unix' do
      system "../dist/configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build_unix' do
      system "make", "docdir=#{CREW_PREFIX}/share/doc/db-6.2.32", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
