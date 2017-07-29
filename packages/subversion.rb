require 'package'

class Subversion < Package
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.9.6'
  source_url 'http://apache.mirrors.ionfish.org/subversion/subversion-1.9.6.tar.bz2'
  source_sha256 'dbcbc51fb634082f009121f2cb64350ce32146612787ffb0f7ced351aacaae19'

  depends_on 'aprutil'
  depends_on 'autoconf'
  depends_on 'libtool'
  depends_on 'serf'
  depends_on 'sqlite'

  def self.build
    system "sed -i 's,<serf.h>,</usr/local/include/serf-1/serf.h>,' subversion/libsvn_ra_serf/*"
    system "sed -i 's,<serf_bucket_util.h>,</usr/local/include/serf-1/serf_bucket_util.h>,' subversion/libsvn_ra_serf/*.c"
    system "sed -i 's,<serf_bucket_types.h>,</usr/local/include/serf-1/serf_bucket_types.h>,' subversion/libsvn_ra_serf/*.c"
    system './configure'
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
