require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '23.03'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://mediaarea.net/download/binary/libmediainfo0/23.03/MediaInfo_DLL_23.03_GNU_FromSource.tar.bz2'
  source_sha256 '18cae1c3a6b1186efe8f474fd1e55900521a9cefdebd89b0ea084808f86e44e6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediainfo/23.03_armv7l/libmediainfo-23.03-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediainfo/23.03_armv7l/libmediainfo-23.03-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediainfo/23.03_i686/libmediainfo-23.03-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmediainfo/23.03_x86_64/libmediainfo-23.03-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '151c5672fed748af22ed39063aaff41f2130e29255522d799bd90964065cfa4a',
     armv7l: '151c5672fed748af22ed39063aaff41f2130e29255522d799bd90964065cfa4a',
       i686: 'd7e47c544d5d8094bc6646de5c44d9cbd1b3b9ed2376d73c995fbce549bc97d4',
     x86_64: '4fc5df9a05958c83a55f80d248d0537137537bc6b7e63fdbf66a019c2de5ca0b'
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
