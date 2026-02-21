require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2025c'
  license 'public-domain'
  compatibility 'all'
  source_url "https://data.iana.org/time-zones/releases/tzdb-#{version}.tar.lz"
  source_sha256 'fbe5b52a151c992c1aeb49bc6ca41e170ca9f8d3fb810ec459eeb79c82d6972b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e6e4630f0cbd342ccd5131ecc9a52cb6384e6a00098ef55f5c539f2800d5a73',
     armv7l: '1e6e4630f0cbd342ccd5131ecc9a52cb6384e6a00098ef55f5c539f2800d5a73',
       i686: 'ab199299d95a1d8d8b37121debf3ecd35aef8045d2c6b5186318331ce5864863',
     x86_64: 'e273aef17205ded1ffdf1ba596c3856b7804231528e34fcce45ef0450df2b506'
  })

  depends_on 'glibc' => :executable_only

  conflicts_ok # Conflicts with coreutils.

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
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'INSTALL'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/tzselect", "#{CREW_DEST_PREFIX}/bin/zoneinfo_tzselect"
    FileUtils.mv "#{CREW_DEST_PREFIX}/sbin/zic", "#{CREW_DEST_PREFIX}/sbin/zoneinfo_zic"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man5/tzfile.5", "#{CREW_DEST_MAN_PREFIX}/man5/zoneinfo_tzfile.5"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man8/zdump.8", "#{CREW_DEST_MAN_PREFIX}/man8/zoneinfo_zdump.8"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man8/zic.8", "#{CREW_DEST_MAN_PREFIX}/man8/zoneinfo_zic.8"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man8/tzselect.8", "#{CREW_DEST_MAN_PREFIX}/man8/zoneinfo_tzselect.8"
  end

  def self.check
    system 'make', 'check'
  end
end
