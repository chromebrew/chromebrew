require 'package'

class Autoconf < Package
  description 'Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages.'
  homepage 'http://www.gnu.org/software/autoconf/'
  version '2.71'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/autoconf/autoconf-2.71.tar.xz'
  source_sha256 'f14c83cfebcc9427f2c3cea7258bd90df972d92eb26752da4ddad81c87a0faa4'

  depends_on 'perl'
  depends_on 'm4'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
