require 'package'

class Mediainfo_gui < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '25.04'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://mediaarea.net/download/binary/mediainfo-gui/#{version}/MediaInfo_GUI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 '6a24f6529ab802e594ce89cc2e7816a2b0ffe06130545c3593ab334f2ceb9cd1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22dc67babe776a8e731bbd3c9d8203506935f8b475f9c4f175e647be99be147f',
     armv7l: '22dc67babe776a8e731bbd3c9d8203506935f8b475f9c4f175e647be99be147f',
     x86_64: 'cadcc0059ce6d49c71e155bcc0965447c3c0bb143296d8379928d117f160fcaf'
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
  depends_on 'libmediainfo' # R
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
