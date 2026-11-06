require 'package'

class Mediainfo_gui < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.10'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://mediaarea.net/download/binary/mediainfo-gui/#{version}/MediaInfo_GUI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'e6255a551b3e19e004814f0eae358967b9d33c7dea1714f15a503f64e795a242'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31252bd363f420200f4119c06cab4a26ba953955e44c582a19b7319541397ecd',
     armv7l: '31252bd363f420200f4119c06cab4a26ba953955e44c582a19b7319541397ecd',
     x86_64: '1900905c19e2340d4348147db1edb0bc35959345f94c39f54b73aa7917d03e5d'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libtiff' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxxf86vm' => :executable
  depends_on 'pango' => :executable
  depends_on 'wxwidgets' => :executable
  depends_on 'zlib' => :executable

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
