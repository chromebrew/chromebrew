require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '23.11'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://mediaarea.net/download/binary/mediainfo/23.11/MediaInfo_CLI_23.11_GNU_FromSource.tar.xz'
  source_sha256 '2f126c3cb7d5d8c1eb45088a2ae327c5e60acc6891c7d842e05f733b4c189bf8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/23.11_armv7l/mediainfo-23.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/23.11_armv7l/mediainfo-23.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/23.11_i686/mediainfo-23.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mediainfo/23.11_x86_64/mediainfo-23.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1106583c2748362f6724dc7c913e44aa7f9dd64fcb5499efdd54c16717b00d38',
     armv7l: '1106583c2748362f6724dc7c913e44aa7f9dd64fcb5499efdd54c16717b00d38',
       i686: '164f4aa1220f90aabb73f3d2aeb38d1888c0fe441f11bbbfa66d97e7c3a2f706',
     x86_64: 'd4d2f92642aac630c91d16ef5d5b65da1d4b3044ce788000b8c9133a0e333dd5'
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
