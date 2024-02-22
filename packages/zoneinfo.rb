require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2024a'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://data.iana.org/time-zones/releases/tzdb-2024a.tar.lz'
  source_sha256 '511af6b467f40b1ec9ac3684d1701793af470f3e29ddfb97b82be438e8601a7a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0daf569178baf4d59c6f6641c3819dba2999cf71e3917d9fc0bf8e1f4149b50',
     armv7l: 'e0daf569178baf4d59c6f6641c3819dba2999cf71e3917d9fc0bf8e1f4149b50',
       i686: '66c5afe3e8961c11bf253d9a8826e1c0c79bd12bad7c1f9645f36ccec363625b',
     x86_64: 'd6a147311371d94f7ec2a4bbf412bd35a83324062adc64a374a1c844db686c86'
  })

  depends_on 'glibc' # R

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
