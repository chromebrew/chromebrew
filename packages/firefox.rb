require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  
  # follow debian patch
  version '87.0-2'
  license 'MPL-2.0, GPL-2 and LGPL-2.1'
  compatibility 'all'

  case ARCH
  when 'i686'
    @_arch = 'i386'
    source_sha256 '5b755e6e1c7c6f508507860b96fdd758c80218940ff6bf67b5508feb6860133e'
  when 'x86_64'
    @_arch = 'amd64'
    source_sha256 '6c59098a23a46ccf376e8f608d04c1765e10e265fa5086e8a622591a415e007e'
  when 'armv7l', 'aarch64'
    @_arch = 'armhf'
    source_sha256 'bd4c13a8cf824c9c9c4f5dbb7ab3d0c1dda3bb5ddc99c53632509f835814e4c1'
  end
  
  source_url "http://ftp.us.debian.org/debian/pool/main/f/firefox/firefox_#{version}_#{@_arch}.deb"

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'dbus'
  depends_on 'dbus_glib'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxcomposite'
  depends_on 'libxcursor'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxi'
  depends_on 'libxrender'
  depends_on 'libxt'
  depends_on 'pango'
  depends_on 'pulseaudio'
  depends_on 'sommelier'

  def self.patch   
    @_wrapper = <<~EOF
      #!/bin/sh
      # To get sound working, used : https://codelab.wordpress.com/2017/12/11/firefox-drops-alsa-apulse-to-the-rescue/
      
      exec apulse #{CREW_PREFIX}/lib/firefox/firefox "$@"
    EOF
    
    FileUtils.rm('./usr/bin/firefox')
    File.write("./bin/firefox", @_wrapper)
    File.chmod(0755, './bin/firefox')
  end

  def self.install
    FileUtils.mkdir_p(CREW_DEST_PREFIX)
    FileUtils.mv('./etc/', CREW_DEST_PREFIX)
    FileUtils.mv(Dir['./usr/*'], CREW_DEST_PREFIX)
  end
end
