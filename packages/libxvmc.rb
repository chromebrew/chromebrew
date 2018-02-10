require 'package'

class Libxvmc < Package
  description 'X.org X-Video Motion Compensation Library'
  homepage 'http://www.x.org'
  version '1.0.10'
  source_url 'https://www.x.org/archive/individual/lib/libXvMC-1.0.10.tar.gz'
  source_sha256 'd8306f71c798d10409bb181b747c2644e1d60c05773c742c12304ab5aa5c8436'

  depends_on 'libxv'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end