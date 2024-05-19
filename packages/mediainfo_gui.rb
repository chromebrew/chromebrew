require 'package'

class Mediainfo_gui < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '24.04'
  license 'BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://mediaarea.net/download/binary/mediainfo-gui/24.04/MediaInfo_GUI_24.04_GNU_FromSource.tar.xz'
  source_sha256 '6a24f6529ab802e594ce89cc2e7816a2b0ffe06130545c3593ab334f2ceb9cd1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd1f7b1babcbd5822228a30cd8d7ec00226cc5c9f98b57807eee75e06c4742f8',
     armv7l: 'bd1f7b1babcbd5822228a30cd8d7ec00226cc5c9f98b57807eee75e06c4742f8',
     x86_64: '89c9cd970e7b46c8ed7dc19bf0df1ba9f7fe8ce1658cc9145475d4c12b78a822'
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
