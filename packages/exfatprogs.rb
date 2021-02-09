require 'package'

class Exfatprogs < Package
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  @_ver = '1.1.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/exfatprogs/exfatprogs/archive/#{@_ver}/exfatprogs-#{@_ver}.tar.gz"
  source_sha256 '88c12a2f9cbe4f12129f3b7fa2cd42f24dbed3f579e61bac2ca699ca79fad4e0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4e2730cc159d86f2f49888f692b199c29490ffac051585777f3ccd09f762145d',
     armv7l: '4e2730cc159d86f2f49888f692b199c29490ffac051585777f3ccd09f762145d',
       i686: '7cf5fe80e0ec6e5933f4d22e278b9a51f057165206167a76005790bcb00793ee',
     x86_64: '8239bb9b62684474dbab1b370e0993c80aceea1d49a57a3b985bada7c58c2725'
  })

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} --sbindir=#{CREW_PREFIX}/bin"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "install -Dm644 -t #{CREW_DEST_PREFIX}/share/man/man8 */*.8"
  end
end
