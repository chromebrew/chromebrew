require 'package'

class Mediainfo_gui < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '25.07'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://mediaarea.net/download/binary/mediainfo-gui/#{version}/MediaInfo_GUI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'eff17dc966290f3ee0f8be0abd279e98eb0d34e1799fbb8b1ec7b210ed624d88'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd18e0f5b105d2c2e1ca0ec134dc4fd7b73dacbe7c95b703cdf913a50274957b',
     armv7l: 'bd18e0f5b105d2c2e1ca0ec134dc4fd7b73dacbe7c95b703cdf913a50274957b',
     x86_64: 'cb8fb802283962a91e2880d6cd79e5c7085a8f12df79832a8208242a24ddc4db'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxxf86vm' # R
  depends_on 'pango' # R
  depends_on 'zlib' # R

  gnome

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./GUI_Compile.sh #{CREW_CONFIGURE_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfo/Project/GNU/GUI' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.postinstall
    ExitMessage.add "\nType 'mediainfo-gui' to get started.\n"
  end
end
