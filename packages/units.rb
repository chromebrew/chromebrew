require 'package'

class Units < Package
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.14'
  source_url 'https://ftp.gnu.org/gnu/units/units-2.14.tar.gz'
  source_sha256 '9d33893d82f3ddd831d5822992007c40bcd0826ae67d3cbc96539951fb0a82e8'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
