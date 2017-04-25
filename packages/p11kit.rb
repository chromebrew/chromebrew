require 'package'

class P11kit < Package
  version '0.23.2'
  source_url 'https://p11-glue.freedesktop.org/releases/p11-kit-0.23.2.tar.gz'
  source_sha1 '4da0d7b47935b6cb0f321dd00358b063ae42df71'

  depends_on 'libffi'
  depends_on 'libtasn1'

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
