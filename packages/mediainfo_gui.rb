require 'package'

class Mediainfo_gui < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.01'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://mediaarea.net/download/binary/mediainfo-gui/#{version}/MediaInfo_GUI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'ecc545afa6e8583f15863c0005f082e7eda46d1bf90a7dadcb644701663ac239'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9d682b4a00406fdf27a1d08e0c49a01fc9a1bad4ce205243e188dca0703bef2',
     armv7l: 'e9d682b4a00406fdf27a1d08e0c49a01fc9a1bad4ce205243e188dca0703bef2',
     x86_64: '6dea56185baf554f08252a2d3d4fb761a49cd0c02c356282b1a8b0b060eefca0'
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
