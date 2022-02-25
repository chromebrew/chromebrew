require 'package'

class Libdmraid < Package
  description 'Device-Mapper Software RAID support tool'
  homepage 'http://people.redhat.com/~heinzm/sw/dmraid/'
  version '1.0.0.rc16-3'    
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'http://people.redhat.com/~heinzm/sw/dmraid/src/dmraid-1.0.0.rc16-3.tar.bz2'
  source_sha256 '93421bd169d71ff5e7d2db95b62b030bfa205a12010b6468dcdef80337d6fbd8'

  depends_on 'gawk' => :build
  depends_on 'lvm2' => :build
  
  def self.build
    Dir.chdir '1.0.0.rc16-3/dmraid' do
      system "autoreconf -fvi"
      system "./configure #{CREW_OPTIONS}"
      system "make || make"
    end
  end

  def self.install
    Dir.chdir '1.0.0.rc16-3/dmraid' do
      system "make install DESTDIR=#{CREW_DEST_DIR}"
    end
  end
end
