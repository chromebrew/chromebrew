require 'package'

class Units < Package
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.19'
  source_url 'https://ftp.gnu.org/gnu/units/units-2.19.tar.gz'
  source_sha256 '4262136bdfc152b63ff5a9b93a7d80ce18b5e8bebdcffddc932dda769e306556'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
