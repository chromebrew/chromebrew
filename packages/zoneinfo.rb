require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2026e'
  license 'public-domain'
  compatibility 'all'
  source_url "https://data.iana.org/time-zones/releases/tzdb-#{version}.tar.lz"
  source_sha256 '4e9c4e9d4587443e716ed42a7070466c1e5975938fb530244a17cf6db883990b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a9bf3808ec04ed175c1e7e07786b4e3ade371d342273201db97f77774ab8f828',
     armv7l: 'a9bf3808ec04ed175c1e7e07786b4e3ade371d342273201db97f77774ab8f828',
       i686: 'd483e805f6a814446f6e4d61b4c9d365624ee614fa3cb63be2f0ab8e70d1c0e3',
     x86_64: '57f073d4295d5f0752f840b4cb970878333602d58edadfa0b9d58981641b1f3e'
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
