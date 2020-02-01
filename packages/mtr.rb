require 'package'

class Mtr < Package
  description "mtr combines the functionality of the 'traceroute' and 'ping' programs in a single network diagnostic tool."
  homepage 'https://www.bitwizard.nl/mtr/'
  version '0.93'
  source_url 'ftp://ftp.bitwizard.nl/mtr/mtr-0.93.tar.gz'
  source_sha256 '229c673d637bd7dbb96471623785a47e85da0b1944978200c949994c1e6af10d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mtr-0.93-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mtr-0.93-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mtr-0.93-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mtr-0.93-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '10827000fd244c4a001077b013ed89d9ee156297764a59b763938e2e261d1965',
     armv7l: '10827000fd244c4a001077b013ed89d9ee156297764a59b763938e2e261d1965',
       i686: '6d42197636f5bc79bd63e879a4e50fa4d13c72e552d8393ac1893b2ae10bf226',
     x86_64: '7ec1e4e20d17fa583089f1ce681c4dd373fdf9683eb36a7d14ede883a2fca0fc',
  })

  def self.build
    system './configure',
           '--without-gtk',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "LDFLAGS=-Wl,-rpath,#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'sudo', 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'sudo', 'chown', '-R', "#{USER}:#{USER}", "#{CREW_DEST_DIR}"
  end

  def self.postinstall
    puts
    puts "To run, execute 'sudo mtr <domain>'".lightblue
    puts
  end
end
