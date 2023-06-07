require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2023c'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://data.iana.org/time-zones/releases/tzdb-2023c.tar.lz'
  source_sha256 '08fd090f1a16d522ae4e9247445056f4155002239e5be760b31ba0376d2e632c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zoneinfo/2023c_armv7l/zoneinfo-2023c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zoneinfo/2023c_armv7l/zoneinfo-2023c-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zoneinfo/2023c_i686/zoneinfo-2023c-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zoneinfo/2023c_x86_64/zoneinfo-2023c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6ecd6e1b0cf305c29e35e048b68cc93053a63e2cf3fe7e319d852e862f4a73c7',
     armv7l: '6ecd6e1b0cf305c29e35e048b68cc93053a63e2cf3fe7e319d852e862f4a73c7',
       i686: '3a0dca29f8249deb77d84caf69bb2049b50098eacbfb9acaf6fbddb4894db71e',
     x86_64: '0ebd46313c486a377673e4552bb301a640d36401f711d535801be770ac9e315e'
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
