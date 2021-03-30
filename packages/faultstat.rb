require 'package'

class Faultstat < Package
  description 'Faultstat measures page fault activity and swap utilization of processes'
  homepage 'https://kernel.ubuntu.com/~cking/faultstat/'
  version '0.01.01-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/faultstat/faultstat-0.01.01.tar.xz'
  source_sha256 '81218818fe7498411797289bdd0967e82665d2065407be8b5335eaf2959b8991'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw make"
  end

  def self.install
    system "install -Dm755 faultstat #{CREW_DEST_PREFIX}/bin/faultstat"
    system "install -Dm644 faultstat.8 #{CREW_DEST_PREFIX}/share/man/man8/faultstat.8"
  end
end
