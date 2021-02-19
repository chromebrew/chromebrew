require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2021a'
  compatibility 'all'
  source_url 'https://data.iana.org/time-zones/releases/tzdb-2021a.tar.lz'
  source_sha256 '21bf125de7b0c486cb57f1ba61b39584c949b2e6cac0a03a6425435d9bff37d0'

  def self.patch
    system "sed -i 's:TZDEFAULT = $(TOPDIR)/etc/localtime:TZDEFAULT = #{CREW_PREFIX}/etc/localtime:g' Makefile"
    system "sed -i 's:USRDIR = usr:USRDIR = usr/local:g' Makefile"
  end

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
  
  def self.postinstall
    system "tzselect"
    puts
    puts "Add `TZ='<timezone>'` to your ~/.bashrc file".lightblue
    puts "Where <timezone> is the timezone displayed above".lightblue
    puts "e.g. `TZ=America/New_York` or `TZ=Etc/UTC`".lightblue
    puts "This won't affect the timezone of non-chromebrew ChromeOS apps."
    puts
  end
end
