require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '91.0.2'
  license 'MPL-2.0, GPL-2 and LGPL-2.1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{version}/linux-i686/en-US/firefox-#{version}.tar.bz2"
    source_sha256 'c52d82b5a73e37c5c80ccf4e206bb80b632bd835968e6bebc7b93c5f4a5acfc9'
  when 'x86_64'
    source_url "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '9eaac9c88ff4696228292590b65ab2fd1b0d98b7a1edf5a21abc11b7803a046d'
  end

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

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/firefox"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/firefox"
    @firefox_sh = <<~FIREFOX_HEREDOC
      #!/bin/bash
      GDK_BACKEND=x11 #{CREW_PREFIX}/firefox/firefox "\$@"
    FIREFOX_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/bin/firefox", @firefox_sh, perm: 0o755)
  end
end
