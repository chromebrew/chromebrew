require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '25.07'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/mediainfo/#{version}/MediaInfo_CLI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'd810a56b84a8f6c009958312459e1d7353b3722db8f18c2bc87da512ebd51482'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'daaea81c433718d4760a8ea6b0dcd6745b380addd374ef2ddd4ec4257ea1df98',
     armv7l: 'daaea81c433718d4760a8ea6b0dcd6745b380addd374ef2ddd4ec4257ea1df98',
       i686: '99647e32da8e872ba14b00fda6caf1cc1db7aa918f83d3cd4bf56b3d66925349',
     x86_64: '9e07a9c7cc8ca950cb01198c6c049c1db1c5d9c66634bc07270618f09daef4f0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

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
