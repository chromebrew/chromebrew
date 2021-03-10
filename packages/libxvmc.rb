require 'package'

class Libxvmc < Package
  description 'X.org X-Video Motion Compensation Library'
  homepage 'http://www.x.org'
  version '1.0.12'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXvMC-1.0.12.tar.gz'
  source_sha256 '024c9ec4f001f037eeca501ee724c7e51cf287eb69ced8c6126e16e7fa9864b5'

  depends_on 'libxv'
  depends_on 'libx11'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
            LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
