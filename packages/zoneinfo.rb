require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2026b'
  license 'public-domain'
  compatibility 'all'
  source_url "https://data.iana.org/time-zones/releases/tzdb-#{version}.tar.lz"
  source_sha256 'ffad46a04c8d1624197056630af475a35f3556d0887f028ac1bd33b7d47dc653'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a9ed89b078b42b0b79c9f02957bf972ea7de3fa66aa5a2d0846ec82b93917990',
     armv7l: 'a9ed89b078b42b0b79c9f02957bf972ea7de3fa66aa5a2d0846ec82b93917990',
       i686: '22df929f5026f929a43e77ae96cecdb3ab78850de1fdbd9eb8b421ecc21cf91d',
     x86_64: 'b8b3505a015a865b8ddab12640c35c588e999a8a951bee1e78f74c325aefd25a'
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
