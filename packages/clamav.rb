require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '0.100.0'
  compatibility 'all'
  source_url 'https://www.clamav.net/downloads/production/clamav-0.100.0.tar.gz'
  source_sha256 'c5c5edaf75a3c53ac0f271148fd6447310bce53f448ec7e6205124a25918f65c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clamav-0.100.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clamav-0.100.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clamav-0.100.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clamav-0.100.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '917bc074de1a0079c37155fad1869c0251c600f80baac8eb48d7569fc7261979',
     armv7l: '917bc074de1a0079c37155fad1869c0251c600f80baac8eb48d7569fc7261979',
       i686: 'b625060b120c70f0003dfa5d08f1e0b7ad8c39a8d78656db0453e5ed2541789d',
     x86_64: '21bc01b195bcfac0d6b678bf0fa9b2fa37698352e373c883ff5b31603a94e622',
  })

  def self.patch
    # Apply patch available at https://bugzilla.clamav.net/show_bug.cgi?id=11711.
    # This will be fixed in next release.
    system "curl -L 'https://bugzilla.clamav.net/attachment.cgi?id=7207' | patch -p0"
  end

  def self.build
    system 'autoconf'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-zlib-vcheck'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
