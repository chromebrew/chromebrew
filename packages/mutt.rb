require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.8.3'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.8.3.tar.gz'
  source_sha256 '9b81746d67ffeca5ea44f60893b70dc93c86d4bc10187d4dd360185e4d42ed42'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.8.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.8.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.8.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mutt-1.8.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fc546348b868f306548fd009f927c75c9fb8cf0b2855d8f1fbb7007d6d5cd7c8',
     armv7l: 'fc546348b868f306548fd009f927c75c9fb8cf0b2855d8f1fbb7007d6d5cd7c8',
       i686: '5b29051fa9a460d2888d5cc1e0bdda10108549c3baa774c30e56a4624a097bee',
     x86_64: '5a3b3dee04f8f5d1219555a4f9c717fde4e032d1fd14509119158eb9d9194062',
  })

  depends_on 'libxslt'

  def self.build
    system './configure --with-mailpath=/usr/local/mail --prefix=/usr/local --enable-imap --with-ssl --enable-smtp'
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/mail"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
