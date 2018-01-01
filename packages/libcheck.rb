require 'package'

class Libcheck < Package
  description 'A unit testing framework for C'
  homepage 'https://github.com/libcheck/check'
  version '0.12.0'
  source_url 'https://github.com/libcheck/check/releases/download/0.12.0/check-0.12.0.tar.gz'
  source_sha256 '464201098bee00e90f5c4bdfa94a5d3ead8d641f9025b560a27755a83b824234'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libtool'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
