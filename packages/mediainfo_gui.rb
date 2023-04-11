require 'package'

class Mediainfo_gui < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '23.03'
  license 'BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://mediaarea.net/download/binary/mediainfo-gui/23.03/MediaInfo_GUI_23.03_GNU_FromSource.tar.bz2'
  source_sha256 'b9fd5783d524a48cdbc68f445b7c3bc9de50d15e088bdd12ceadd1c2d3790efd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo_gui/23.03_armv7l/mediainfo_gui-23.03-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo_gui/23.03_armv7l/mediainfo_gui-23.03-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo_gui/23.03_x86_64/mediainfo_gui-23.03-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9a1266e2d0333f8b54965649f194c9fb6f75f2af7d27b613b34f57979b78c8f3',
     armv7l: '9a1266e2d0333f8b54965649f194c9fb6f75f2af7d27b613b34f57979b78c8f3',
     x86_64: '9130347f6684366594dc92af2e305652c47b24607fb1c86e0bbf8a8b7f3994a6'
  })

  depends_on 'libmediainfo'
  depends_on 'gtk3'

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./GUI_Compile.sh #{CREW_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfo/Project/GNU/GUI' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
