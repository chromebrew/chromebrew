require 'package'

class Libmetalink < Package
  description 'libmetalink is a Metalink library written in C language.'
  homepage 'https://launchpad.net/libmetalink/'
  compatibility 'all'
  version '0.1.3-2'
  source_url 'https://launchpad.net/libmetalink/trunk/libmetalink-0.1.3/+download/libmetalink-0.1.3.tar.xz'
  source_sha256 '86312620c5b64c694b91f9cc355eabbd358fa92195b3e99517504076bf9fe33a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b47564f58da6ce1215010fd9ad152a568f5cae15a466b43b59b871d1469efb25',
     armv7l: 'b47564f58da6ce1215010fd9ad152a568f5cae15a466b43b59b871d1469efb25',
       i686: 'f216916b8b89a717f923adb72f446c45c97c057347a71c1b7326224c49d25257',
     x86_64: '01d87388e27c2d918fa29e885d2818956a7c42297df9d08da772f52f12ff5249'
  })

  def self.patch
    puts 'Downloading patch...'
    system 'curl', '--progress-bar', '-LO', 'https://launchpadlibrarian.net/380798344/0001-fix-covscan-issues.patch'
    unless Digest::SHA256.hexdigest(File.read('0001-fix-covscan-issues.patch')) == 'd236dfa0d4a1938a40ff2ce4dd348c42b74ad68807df0f1b6ea69c11725fd9cf'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    puts 'Done!'.lightgreen
    puts 'Applying patch...'
    system 'patch', '-Np1', '-i', '0001-fix-covscan-issues.patch'
    puts 'Done!'.lightgreen
  end

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-libxml2\
      --without-libexpat \
      --program-prefix='' --program-suffix='' "
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
