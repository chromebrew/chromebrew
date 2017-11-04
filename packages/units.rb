require 'package'

class Units < Package
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.16'
  source_url 'https://ftp.gnu.org/gnu/units/units-2.16.tar.gz'
  source_sha256 'dcf3f78482a13b150fc6bf0f8d611510816a3424bc2b26229b85b1cadeb81686'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
