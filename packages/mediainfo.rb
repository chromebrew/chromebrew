require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '17.12'
  compatibility 'all'
  source_url 'http://mediaarea.net/download/binary/mediainfo/17.12/MediaInfo_CLI_17.12_GNU_FromSource.tar.bz2'
  source_sha256 '0f23ccc9a78b24104dc387691e1df484ed75350ee77277982cd170cca59750b0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mediainfo-17.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mediainfo-17.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mediainfo-17.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mediainfo-17.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a963c89216f20971448bc34dc69b868d9bb3aa106d9cd6cb0eb5884ebd9e08b3',
     armv7l: 'a963c89216f20971448bc34dc69b868d9bb3aa106d9cd6cb0eb5884ebd9e08b3',
       i686: '700b4c95aa8d9693638eec5202bdaf2975840000ff0325ae48fbda770a867e76',
     x86_64: '29566ace5b5966c57ec206e2d17ca32592b116b968e65565ae6c1e4510daae46',
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
