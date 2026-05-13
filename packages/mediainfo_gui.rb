require 'package'

class Mediainfo_gui < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.05'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://mediaarea.net/download/binary/mediainfo-gui/#{version}/MediaInfo_GUI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'dec17d1d02e2df2fa79b5348a81ee14a1e60b400b6681b3cdf0c0823e8c94b35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a03c6721e7564560c469932f6819451da1cfb2658faf5e89fd906b03d63f51f',
     armv7l: '6a03c6721e7564560c469932f6819451da1cfb2658faf5e89fd906b03d63f51f',
     x86_64: 'ab3450ee6ba92e332dc3ac57ebd1d2af0e639120e2f9285072078763155ba968'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libtiff' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxxf86vm' => :executable
  depends_on 'pango' => :executable
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
