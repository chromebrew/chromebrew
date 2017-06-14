require 'package'

class Mlocate < Package
  description 'mlocate is a locate/updatedb implementation.'
  homepage 'https://pagure.io/mlocate'
  version '0.26-1'
  source_url 'https://releases.pagure.org/mlocate/mlocate-0.26.tar.xz'
  source_sha1 'c6e6d81b25359c51c545f4b8ba0f3b469227fcbc'

  def self.build
    system "mkdir -p /usr/local/db/mlocate"
    system "sed -i 's,\$(localstatedir)/,/usr/local/db/,g' Makefile.*"
    system "sed -i \"s/groupname = mlocate/groupname = $(whoami)/g\" Makefile.*"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
