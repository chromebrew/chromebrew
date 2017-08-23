require 'package'

class Xmlto < Package
  description 'A tool for converting XML files to various formats.'
  homepage 'https://pagure.io/xmlto'
  version '0.0.28'
  source_url 'https://releases.pagure.org/xmlto/xmlto-0.0.28.tar.bz2'
  source_sha256 '1130df3a7957eb9f6f0d29e4aa1c75732a7dfb6d639be013859b5c7ec5421276'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
