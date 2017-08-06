require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.8.3'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.8.3.tar.gz'
  source_sha256 '9b81746d67ffeca5ea44f60893b70dc93c86d4bc10187d4dd360185e4d42ed42'

  depends_on 'libxslt'

  def self.build
    system 'mkdir /usr/local/mail'
    system './configure --with-mailpath=/usr/local/mail --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/mail"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
