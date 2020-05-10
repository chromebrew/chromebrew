
require 'package'

class Libmetalink < Package
  description 'libmetalink is a Metalink library written in C language.'
  homepage 'https://launchpad.net/libmetalink/'
  compatibility 'all'
  version '0.1.3'
  source_url 'https://launchpad.net/libmetalink/trunk/libmetalink-0.1.3/+download/libmetalink-0.1.3.tar.xz'
  source_sha256 '86312620c5b64c694b91f9cc355eabbd358fa92195b3e99517504076bf9fe33a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '29e31d4461af785016c7fc39dad45479e943488cdcf60a77ed06bb09ec61ea82',
     armv7l: '29e31d4461af785016c7fc39dad45479e943488cdcf60a77ed06bb09ec61ea82',
       i686: 'd289f088f022b0ebd91585afb9a8f12f5ffd2ad86efacfdf13aaffdfb0cb9634',
     x86_64: '26c796170ae70679c0cc6ba510b5fd94594e2436b8ae14733226e6b294762fc3',
  })

  depends_on 'libxml2'

  def self.patch
    puts 'Downloading patch...'
    system 'curl', '--progress-bar', '-LO', 'https://launchpadlibrarian.net/380798344/0001-fix-covscan-issues.patch'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('0001-fix-covscan-issues.patch') ) == 'd236dfa0d4a1938a40ff2ce4dd348c42b74ad68807df0f1b6ea69c11725fd9cf'
    puts 'Done!'.lightgreen
    puts 'Applying patch...'
    system 'patch', '-Np1', '-i', '0001-fix-covscan-issues.patch'
    puts 'Done!'.lightgreen
  end

  def self.build
    system './configure',
           '--with-libxml2',
           '--disable-static',
           '--without-libexpat',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
