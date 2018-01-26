require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '17.12'
  source_url 'http://mediaarea.net/download/binary/mediainfo/17.12/MediaInfo_CLI_17.12_GNU_FromSource.tar.bz2'
  source_sha256 '0f23ccc9a78b24104dc387691e1df484ed75350ee77277982cd170cca59750b0'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./CLI_Compile.sh --prefix=#{CREW_PREFIX}"
  end

  def self.install
    Dir.chdir 'MediaInfo/Project/GNU/CLI' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
