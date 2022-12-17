require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '22.09'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://mediaarea.net/download/binary/mediainfo/22.09/MediaInfo_CLI_22.09_GNU_FromSource.tar.bz2'
  source_sha256 'cbeb09e63d77e10d74ff5ee3c4955f7ff848796f506d64cbed3d6e828632d52b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/22.09_armv7l/mediainfo-22.09-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/22.09_armv7l/mediainfo-22.09-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/22.09_i686/mediainfo-22.09-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/22.09_x86_64/mediainfo-22.09-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c9f8c08e3b443beea717e7a709b799930f3f68188e17c232b952bc1e4920b955',
     armv7l: 'c9f8c08e3b443beea717e7a709b799930f3f68188e17c232b952bc1e4920b955',
       i686: '5e3d9d17a62739aebb3ea66a43641dabd62aaaa3fbd17a67fd4efbc21e98271e',
     x86_64: '235aae12f22bc6dee1e57b3871780eeecb950f87cd89c4a49dfddd6131ddaa44'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./CLI_Compile.sh #{CREW_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfo/Project/GNU/CLI' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
