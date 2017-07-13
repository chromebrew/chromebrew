require 'package'

class Mlocate < Package
  description 'mlocate is a locate/updatedb implementation.'
  homepage 'https://pagure.io/mlocate'
  version '0.26-1'
  source_url 'https://releases.pagure.org/mlocate/mlocate-0.26.tar.xz'
  source_sha256 '3063df79fe198fb9618e180c54baf3105b33d88fe602ff2d8570aaf944f1263e'

  def self.build
    system "mkdir -p /usr/local/db/mlocate"
    system "sed -i 's,\$(localstatedir)/,/usr/local/db/,g' Makefile.*"
    system "sed -i \"s/groupname = mlocate/groupname = #{USER}/g\" Makefile.*"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
