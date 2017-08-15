require 'package'

class Libcheck < Package
  description 'A unit testing framework for C'
  homepage 'https://github.com/libcheck/check'
  version '0.11.0'
  source_url 'https://github.com/libcheck/check/releases/download/0.11.0/check-0.11.0.tar.gz'
  source_sha256 '24f7a48aae6b74755bcbe964ce8bc7240f6ced2141f8d9cf480bc3b3de0d5616'

  depends_on 'libtool'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
