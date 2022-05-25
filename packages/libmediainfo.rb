require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '23.11'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://mediaarea.net/download/binary/libmediainfo0/23.11/MediaInfo_DLL_23.11_GNU_FromSource.tar.xz'
  source_sha256 '7ffa6728840dd022af261b665dbf0c3cd8419b8001abcdc507801944bcaaa7a6'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediainfo/23.11_armv7l/libmediainfo-23.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediainfo/23.11_armv7l/libmediainfo-23.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediainfo/23.11_i686/libmediainfo-23.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediainfo/23.11_x86_64/libmediainfo-23.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a897d1fc07ea2de848275dadfca354e786809c5e3d0155fed556c0eb0649956c',
     armv7l: 'a897d1fc07ea2de848275dadfca354e786809c5e3d0155fed556c0eb0649956c',
       i686: '981a710eff8bd7c45bdb73ba46589e875f6cfbb731274e6baae9c606054bdffa',
     x86_64: 'ce74c4ff5b7d4e0957858313aadfbe9c0aadd6bb67c13b8424d10323d408a031'
  })

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "mold -run ./SO_Compile.sh #{CREW_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfoLib/Project/GNU/Library' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
