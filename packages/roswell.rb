require 'package'

class Roswell < Package
  description 'A lisp installer and launcher for major environment.'
  homepage 'https://github.com/roswell/roswell'
  version '20.01.14.104'
  compatibility 'all'
  source_url 'https://github.com/roswell/roswell/archive/v20.01.14.104.tar.gz'
  source_sha256 '798b96fdcb8c89445b36692b31570bb99882d83719d6310d969ccfcb2a35a1d4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'brotli'
  depends_on 'curl'
  depends_on 'libcyrussasl'
  depends_on 'libnghttp2'
  depends_on 'openldap'
  depends_on 'rtmpdump'

  def self.build
    system 'sh bootstrap'
    system './configure', "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
