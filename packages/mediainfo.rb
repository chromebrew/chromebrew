require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.05'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/mediainfo/#{version}/MediaInfo_CLI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 '220e54edc92a559cf8c2b4e332eba0116f9f758b2588ea02d432d1894a569c6a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3a7db2e5617200fc4fb4222a201c13049624312c584f9b656e3b538b8955273',
     armv7l: 'a3a7db2e5617200fc4fb4222a201c13049624312c584f9b656e3b538b8955273',
       i686: 'acc1ee3be53b92701f9045e0ccedebc0fec26df34315ad9aa92be10315d79f53',
     x86_64: '358f9dc0337d8577a4a4f62b0415c995e0ad1720e934886ae2bc74c4f21b16bf'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'zlib' => :executable

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./CLI_Compile.sh #{CREW_CONFIGURE_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfo/Project/GNU/CLI' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
