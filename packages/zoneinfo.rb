require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2026f'
  license 'public-domain'
  compatibility 'all'
  source_url "https://data.iana.org/time-zones/releases/tzdb-#{version}.tar.lz"
  source_sha256 '357829e3a16a78224d23f1ae2327704c1da1fd35f6769a7aac0682755fb9027a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7ca2ccba5be6e6357430b94a1c2b678894766abbb9a28114ec7e626277e3843',
     armv7l: 'e7ca2ccba5be6e6357430b94a1c2b678894766abbb9a28114ec7e626277e3843',
       i686: 'ebf9980c2f922cb270e218847b7fcf284eb068be0a62830aa07384eeae1e2d40',
     x86_64: '72579ffc6888c140951330b89084e570b7916b243c29aa3f1f7e61ebe768573d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

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
