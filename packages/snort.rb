require 'package'

class Snort < Package
  description 'Snort is an open source intrusion prevention system capable of real-time traffic analysis and packet logging.'
  homepage 'https://www.snort.org/'
  version '2.9.11.1'
  source_url 'https://www.snort.org/downloads/snort/snort-2.9.11.1.tar.gz'
  source_sha256 '9f6b3aeac5a109f55504bd370564ac431cb1773507929dc461626898f33f46cd'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'daq'
  depends_on 'libdnet'
  depends_on 'libtirpc'
  depends_on 'pcre'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-sourcefire'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
