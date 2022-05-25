require 'package'

class Libxaw < Package
  description 'X.org X Athena Widgets Library'
  homepage 'http://www.x.org'
  version '1.0.13'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXaw-1.0.13.tar.gz'
  source_sha256 '7e74ac3e5f67def549722ff0333d6e6276b8becd9d89615cda011e71238ab694'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxaw/1.0.13_armv7l/libxaw-1.0.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxaw/1.0.13_armv7l/libxaw-1.0.13-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxaw/1.0.13_i686/libxaw-1.0.13-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxaw/1.0.13_x86_64/libxaw-1.0.13-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '060f03d386499cd87f69a373aa0d65c6378ade1340d0cf6b022bbd6a9fd8c31b',
     armv7l: '060f03d386499cd87f69a373aa0d65c6378ade1340d0cf6b022bbd6a9fd8c31b',
       i686: '661ecedb9b29f7d6c607a68815911355751bd130d1e30a7d23b326ee8d799981',
     x86_64: 'ecb522f416267f59ac30bd21d42b7a97940ceb350eb73127b213c8ec46cde70c'
  })

  depends_on 'libxmu'
  depends_on 'libxpm'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
