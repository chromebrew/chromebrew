require 'package'

class Netsurf_buildsystem < Package
  description 'Netsurf buildsystem'
  homepage 'https://www.netsurf-browser.org'
  version '1.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/buildsystem-1.9.tar.gz'
  source_sha256 '93841e314a688209a20b8745f065393f3a90f01be68f45e96bc8d2f4a2aa9a2a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '2602d191183cf92d0c44fc4ce81a16a64e9b28211c07559102b3d25fe86ac8fb',
     armv7l: '2602d191183cf92d0c44fc4ce81a16a64e9b28211c07559102b3d25fe86ac8fb',
       i686: 'fe44c36fd24f61c8454af3f56d5ea1e6e3ba994f229d080305b1f91521b7435c',
     x86_64: '1977f7513bf92f0655eafd1d453e3bd33395b894084d30b766bc5f96a073a56e'
  })

  def self.build
    system "make PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared DESTDIR=#{CREW_DEST_DIR}"
  end
end
