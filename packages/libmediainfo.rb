require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.05'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/libmediainfo0/#{version}/MediaInfo_DLL_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'c1ebf9a6b84d0a02d7a0bce63b420273b9459012d64ad57bcf23ec3b26949008'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62a56e7417a6a0bea4f27e00b117f969104c25a1f2f3e0c318a55d8684f116c5',
     armv7l: '62a56e7417a6a0bea4f27e00b117f969104c25a1f2f3e0c318a55d8684f116c5',
       i686: '97c80197a936d0068dce0b2b4020aea898a330ef5df0e651a4fb44393fced98d',
     x86_64: 'afeb58f4ed4726f581d1bd9570609d27e6918614a3b04faf5a8b70e8b4763040'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./SO_Compile.sh #{CREW_CONFIGURE_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfoLib/Project/GNU/Library' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
