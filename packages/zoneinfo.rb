require 'package'

class Zoneinfo < Package
  description 'Code and data that represent the history of local time for many representative locations around the globe.'
  homepage 'https://www.iana.org/time-zones'
  version '2021a'
  compatibility 'all'
  source_url 'https://data.iana.org/time-zones/releases/tzdb-2021a.tar.lz'
  source_sha256 '21bf125de7b0c486cb57f1ba61b39584c949b2e6cac0a03a6425435d9bff37d0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zoneinfo-2021a-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zoneinfo-2021a-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zoneinfo-2021a-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zoneinfo-2021a-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '90df3fefec5c3a6c74dc8f5ebc9c71eedafe4d8640c4925bbe06add4a860c4b4',
     armv7l: '90df3fefec5c3a6c74dc8f5ebc9c71eedafe4d8640c4925bbe06add4a860c4b4',
       i686: '90525ed6a5f9ffd5428c626c24e1cf57442568720388a646846ceb86a1c725d2',
     x86_64: '09996f9d306829c341d5959bb2a8c59064c2e89c547b160edc6b0244f54bf0d7'
  })

  def self.patch
    system "sed -i 's:TZDEFAULT = $(TOPDIR)/etc/localtime:TZDEFAULT = #{CREW_PREFIX}/etc/localtime:g' Makefile"
    system "sed -i 's:USRDIR = usr:USRDIR = usr/local:g' Makefile"
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      make ALL"
    # This fixed failure of make check on i686 & armv7l.
    system 'make force_tzs'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'INSTALL'
  end

  def self.check
    system 'make', 'check'
  end

  def self.postinstall
    # Do not run tzselect if shell is non-interactive.
    system('tty -s || tzselect ;;')
    puts
    puts "Add `TZ='<timezone>'` to your ~/.bashrc file".lightblue
    puts 'Where <timezone> is the timezone displayed above'.lightblue
    puts 'e.g. `TZ=America/New_York` or `TZ=Etc/UTC`'.lightblue
    puts "This won't affect the timezone of non-chromebrew ChromeOS apps."
    puts
  end
end
