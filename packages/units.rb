require 'package'

class Units < Package
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.19'
  license 'FDL-1.3 and GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/units/units-2.19.tar.gz'
  source_sha256 '4262136bdfc152b63ff5a9b93a7d80ce18b5e8bebdcffddc932dda769e306556'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e49576db081d5ea2e78fffbae17b0140895b8956bc21707519f2a240bf6ae149',
     armv7l: 'e49576db081d5ea2e78fffbae17b0140895b8956bc21707519f2a240bf6ae149',
       i686: 'b4ac65ba8c5961a8e3f3f9d9fa4a38ebb988aee06cfe5d17cc3861d1ec77572a',
     x86_64: 'a2aaaa83951b519431e14738d5eebd4caea2a16375f195efb5240b34a2789981'
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
