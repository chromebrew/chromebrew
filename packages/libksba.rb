require 'package'

class Libksba < Package
  description 'Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy.'
  homepage 'https://www.gnupg.org/related_software/libksba/index.html'
  version '1.6.0'
  license 'LGPL-3+, GPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.6.0.tar.bz2'
  source_sha256 'dad683e6f2d915d880aa4bed5cea9a115690b8935b78a1bbe01669189307a48b'

  depends_on 'libgpgerror'
  depends_on 'npth'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system 'make', 'check'
  end
end
