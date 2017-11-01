require 'package'

class Units < Package
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.15'
  source_url 'https://ftp.gnu.org/gnu/units/units-2.15.tar.gz'
  source_sha256 '25d6334fafc801e15b3b0388e207e1efc5d4ae88af6dc7b17d3913de6441f47c'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
