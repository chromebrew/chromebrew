require 'package'

class Atool < Package
  description 'A script for managing file archives of various types.'
  homepage 'http://www.nongnu.org/atool/'
  version '0.39'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'http://download.savannah.gnu.org/releases/atool/atool-0.39.0.tar.gz'
  source_sha256 'aaf60095884abb872e25f8e919a8a63d0dabaeca46faeba87d12812d6efc703b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '10d316dddae76dbb595c8ab0f5cf1486d40f18f6c20c151b46c614313a6fc822',
     armv7l: '10d316dddae76dbb595c8ab0f5cf1486d40f18f6c20c151b46c614313a6fc822',
       i686: '690926e3c631340d2e3f0a91390d4a0c4c8ab1dd9001dc0aaf8eff019eaeb3d7',
     x86_64: 'e8e9a3db6efd80ad3b5b18725c4c5c4816e56fc101ca273de072af489f8c0d1e'
  })

  depends_on 'perl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install' # the steps required to install the package
  end
end
