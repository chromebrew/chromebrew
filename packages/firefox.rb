require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '155.0'
  license 'MPL-2.0, GPL-2 and LGPL-2.1'
  compatibility 'x86_64'
  min_glibc '2.35'
  source_url "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.xz"
  source_sha256 'fd9ec3f5f113d0825ca0bd1ab3c0756fbc40241034eefce6743be953bcca7473'

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dbus' # R
  depends_on 'dbus_glib' => :logical
  depends_on 'desktop_file_utils' => :logical
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxcursor' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxi' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'pango' # R
  depends_on 'pulseaudio' => :logical
  depends_on 'sommelier' => :logical

  no_compile_needed
  no_shrink

  def self.build
    File.write 'firefox_sh', <<~FIREFOX_SH
      #!/bin/bash
      GDK_BACKEND=x11 #{CREW_PREFIX}/share/firefox/firefox "$@"
    FIREFOX_SH
    # For some reason, the binaries do not have a desktop file so add it here.
    File.write 'firefox_desktop', <<~FIREFOX_DESKTOP
      [Desktop Entry]
      Version=#{version}
      Name=Firefox
      Name[en_US]=firefox
      GenericName=Mozilla Firefox
      GenericName[en_US]=Mozilla Firefox
      Comment=Free and open-source web browser
      Exec=firefox %U
      Terminal=false
      Type=Application
      Icon=firefox
      Categories=Network;WebBrowser;
      MimeType=text/html;text/xml;application/xhtml_xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;
    FIREFOX_DESKTOP
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/firefox"
    icon_base_path = "#{CREW_DEST_PREFIX}/share/icons/hicolor"
    FileUtils.mkdir_p "#{icon_base_path}/16x16/apps"
    FileUtils.mkdir_p "#{icon_base_path}/32x32/apps"
    FileUtils.mkdir_p "#{icon_base_path}/48x48/apps"
    FileUtils.mkdir_p "#{icon_base_path}/64x64/apps"
    FileUtils.mkdir_p "#{icon_base_path}/128x128/apps"
    FileUtils.mkdir_p "#{icon_base_path}/256x256/apps"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/firefox"
    FileUtils.install 'firefox_sh', "#{CREW_DEST_PREFIX}/bin/firefox", mode: 0o755
    FileUtils.install 'firefox_desktop', "#{CREW_DEST_PREFIX}/share/applications/firefox.desktop", mode: 0o644
    Dir.chdir 'browser/chrome/icons/default' do
      FileUtils.mv 'default16.png', "#{icon_base_path}/16x16/apps/firefox.png"
      FileUtils.mv 'default32.png', "#{icon_base_path}/32x32/apps/firefox.png"
      FileUtils.mv 'default48.png', "#{icon_base_path}/48x48/apps/firefox.png"
      FileUtils.mv 'default64.png', "#{icon_base_path}/64x64/apps/firefox.png"
      FileUtils.mv 'default128.png', "#{icon_base_path}/128x128/apps/firefox.png"
    end
    # The following image is needed for crew-launcher which requires a minimum icon size of 144x144.
    downloader 'https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/firefox-browser-icon.png',
               'f4784581b3bea8d49e7c06b535bb4266fc3f6f406740b8f6132b2ce09386efd8'
    FileUtils.install 'firefox-browser-icon.png', "#{icon_base_path}/512x512/apps/firefox.png", mode: 0o644
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Firefox', 'firefox')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Firefox', 'firefox')
  end

  def self.postremove
    if Dir.exist?("#{HOME}/.mozilla/seamonkey")
      Package.agree_to_remove("#{HOME}/.mozilla/firefox")
    else
      Package.agree_to_remove("#{HOME}/.mozilla")
    end
  end
end
