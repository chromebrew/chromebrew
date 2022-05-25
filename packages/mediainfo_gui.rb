require 'package'

class Mediainfo_gui < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '23.11'
  license 'BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://mediaarea.net/download/binary/mediainfo-gui/23.11/MediaInfo_GUI_23.11_GNU_FromSource.tar.xz'
  source_sha256 'b9fd5783d524a48cdbc68f445b7c3bc9de50d15e088bdd12ceadd1c2d3790efd'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo_gui/23.11_armv7l/mediainfo_gui-23.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo_gui/23.11_armv7l/mediainfo_gui-23.11-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo_gui/23.11_x86_64/mediainfo_gui-23.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '48a38130e32ceb1ba9a4d8aba369b81647216791a1158df5bbc72ea3b8a43585',
     armv7l: '48a38130e32ceb1ba9a4d8aba369b81647216791a1158df5bbc72ea3b8a43585',
     x86_64: 'b60b01c223074aa0c2a0def0fec32dd05f322b758e960508cf6d36a59a3c62cc'
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
