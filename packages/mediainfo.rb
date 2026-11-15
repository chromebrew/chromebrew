require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.10'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/mediainfo/#{version}/MediaInfo_CLI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 '7785bb75d69efd21b7c0b2c2269164aeb21cea2be6f6b9103ad79743af6fdec7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e512452459d44af9ea979ce2d58b7f72e168111019e7dc03b370e1eadc754d42',
     armv7l: 'e512452459d44af9ea979ce2d58b7f72e168111019e7dc03b370e1eadc754d42',
       i686: 'efea575baf0881f90842441e32789a8a9a4b19abcc3c65257bc2be88d5eb7994',
     x86_64: '2ed12f4cbf995b8ba902fb6b97880c60166dc94ec8786106d57f7306b8bd6aa5'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
