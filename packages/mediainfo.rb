require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '23.03'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://mediaarea.net/download/binary/mediainfo/23.03/MediaInfo_CLI_23.03_GNU_FromSource.tar.bz2'
  source_sha256 '1c6692bf146ee107ee224af20c28ed5acc6879a8584be51914c4f212d56fe205'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/23.03_armv7l/mediainfo-23.03-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/23.03_armv7l/mediainfo-23.03-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/23.03_i686/mediainfo-23.03-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/23.03_x86_64/mediainfo-23.03-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'da14fe71564dd40069ab8aead8d29733094859ef0ed4f4155667487587e4038b',
     armv7l: 'da14fe71564dd40069ab8aead8d29733094859ef0ed4f4155667487587e4038b',
       i686: 'e81399c39169201f3bb76aba8c3fc3ae8fe22d7d13693f0088db22d949ab6543',
     x86_64: '168c887710a06d43c517e6d4b87c55a05223f3e56272cb5b340331d3a61068fd'
  })

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "mold -run ./CLI_Compile.sh #{CREW_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfo/Project/GNU/CLI' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
