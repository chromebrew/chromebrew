require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '139.0.4'
  license 'MPL-2.0, GPL-2 and LGPL-2.1'
  compatibility 'x86_64'
  min_glibc '2.35'
  source_url "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.xz"
  source_sha256 'fe22686f09a0c46390fea430b26cccc323d92af26869699f394f25b5e71527a3'

  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'desktop_file_utils'
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
    downloader 'https://images.freeimages.com/fic/images/icons/783/mozilla_pack/256/firefox.png',
               '314c3d2fe4cce3629007519a08e21c7aea8bd65ec262a11b00c0f583dd4a2087'
    FileUtils.install 'firefox.png', "#{icon_base_path}/256x256/apps/firefox.png", mode: 0o644
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
