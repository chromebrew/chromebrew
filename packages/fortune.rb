require 'package'

class Fortune < Package
  description 'Fortune is a small game that is meant to lighten up your life. It can be used to display a random entry from a cookie file.'
  homepage 'https://www.fefe.de/fortune/'
  version '1.2'
  compatibility 'all'
  source_url 'http://dl.fefe.de/fortune-1.2.tar.bz2'
  source_sha256 'cbb246a500366db39ce035632eb4954e09f1e03b28f2c4688864bfa8661b236a'

  depends_on "fortunes"

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},' fortune.c"
    system "make"
  end

  def self.install
    system "install -Dm755 fortune #{CREW_DEST_PREFIX}/bin/fortune"
  end
end
