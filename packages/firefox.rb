require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '119.0'
  license 'MPL-2.0, GPL-2 and LGPL-2.1'
  compatibility 'x86_64'
  source_url "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.bz2"
  source_sha256 '3cba47e712cec5de5716666ef640f678d65ffb3c8ed5a67986296dcfa59fbc32'

  depends_on 'at_spi2_core'
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

  no_compile_needed
  no_shrink
  no_fhs

  def self.build
    File.write 'firefox_sh', <<~FIREFOX_SH
      #!/bin/bash
      GDK_BACKEND=x11 #{CREW_PREFIX}/firefox/firefox "\$@"
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/firefox"
    icon_base_path = "#{CREW_DEST_PREFIX}/share/icons/hicolor"
    FileUtils.mkdir_p "#{icon_base_path}/16x16/apps"
    FileUtils.mkdir_p "#{icon_base_path}/32x32/apps"
    FileUtils.mkdir_p "#{icon_base_path}/48x48/apps"
    FileUtils.mkdir_p "#{icon_base_path}/64x64/apps"
    FileUtils.mkdir_p "#{icon_base_path}/128x128/apps"
    FileUtils.mkdir_p "#{icon_base_path}/256x256/apps"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/firefox"
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
    downloader 'https://files.softicons.com/download/application-icons/round-app-icons-by-ampeross/png/256x256/Mozilla.png',
               '994e780ada1456c26b077a9f97186aefbc90be5c57e66366b1bca32df0c14c4e'
    FileUtils.mv 'Mozilla.png', "#{icon_base_path}/256x256/apps/firefox.png"
  end

  def self.postinstall
    print "\nSet Firefox as your default browser? [Y/n]: "
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'firefox', 'x-www-browser'
      end
      puts 'Firefox is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    puts "\nType 'firefox' to get started.\n".lightblue
  end
end
