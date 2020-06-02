
require 'package'

class Libmetalink < Package
  description 'libmetalink is a Metalink library written in C language.'
  homepage 'https://launchpad.net/libmetalink/'
<<<<<<< HEAD
  compatibility 'all'
  version '0.1.3'
=======
  version '0.1.3-1'
>>>>>>> master
  source_url 'https://launchpad.net/libmetalink/trunk/libmetalink-0.1.3/+download/libmetalink-0.1.3.tar.xz'
  source_sha256 '86312620c5b64c694b91f9cc355eabbd358fa92195b3e99517504076bf9fe33a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '25b93f3304ee1cf1a06c582de5c053436322b08fb27a576d132130bf73ef436b',
     armv7l: '25b93f3304ee1cf1a06c582de5c053436322b08fb27a576d132130bf73ef436b',
       i686: 'd10d7a95750b93be70f457d6c5db8935e30f85a726bf154d2953d075bd28d216',
     x86_64: '6e1e4b07e44e4b8cf1c436a6594f333bf339803c4c04a6c5a4f1762e00409479',
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
    system "./configure #{CREW_OPTIONS} --with-libxml2 --disable-static --without-libexpat"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
