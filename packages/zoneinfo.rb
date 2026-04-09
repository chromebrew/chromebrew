require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2026a'
  license 'public-domain'
  compatibility 'all'
  source_url "https://data.iana.org/time-zones/releases/tzdb-#{version}.tar.lz"
  source_sha256 '0913509a37f26b81bb6396018ad5cdf32065374ed36e82cceb61b2ee57a94b7c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3bd3779f7cf7ccc75005ae17c08e09b12c7d72bb4287ecc7e89b0c0723625fdb',
     armv7l: '3bd3779f7cf7ccc75005ae17c08e09b12c7d72bb4287ecc7e89b0c0723625fdb',
       i686: 'bdc41a48fee778d6395daf9bd8fd92070f39262705e96b22a7c22adf5b241c2a',
     x86_64: '92c0953051b5ba5c17154b7e02aae6cd08e824a3799191db18ba8f94e7adc6af'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library

  def self.patch
    system "sed -i 's:TZDEFAULT = $(TOPDIR)/etc/localtime:TZDEFAULT = #{CREW_PREFIX}/etc/localtime:g' Makefile"
    system "sed -i 's:USRDIR = usr:USRDIR = usr/local:g' Makefile"
  end

  def self.build
    system 'make ALL'
    # This fixed failure of make check on i686 & armv7l.
    system 'make force_tzs'
  end

  def self.install
    system 'make', "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'INSTALL'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/date", "#{CREW_DEST_PREFIX}/bin/zoneinfo_date"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/tzselect", "#{CREW_DEST_PREFIX}/bin/zoneinfo_tzselect"
    FileUtils.mv "#{CREW_DEST_PREFIX}/sbin/zic", "#{CREW_DEST_PREFIX}/sbin/zoneinfo_zic"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man1/date.1", "#{CREW_DEST_MAN_PREFIX}/man1/zoneinfo_date.1"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man5/tzfile.5", "#{CREW_DEST_MAN_PREFIX}/man5/zoneinfo_tzfile.5"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man8/zdump.8", "#{CREW_DEST_MAN_PREFIX}/man8/zoneinfo_zdump.8"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man8/zic.8", "#{CREW_DEST_MAN_PREFIX}/man8/zoneinfo_zic.8"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man8/tzselect.8", "#{CREW_DEST_MAN_PREFIX}/man8/zoneinfo_tzselect.8"
  end

  def self.check
    system 'make', 'check'
  end
end
