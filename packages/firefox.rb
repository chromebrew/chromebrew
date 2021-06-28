require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '89.0.2'
  license 'MPL-2.0, GPL-2 and LGPL-2.1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-i686/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '491fd0066a893fdb3a6cc58e3e0b6b02f15096d07563437a79b2727d09256890'
  when 'x86_64'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '964b6b515151bb9a0f4e90e9902afd09ff64bfaafa231480b9829264d36fd76f'
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
    FileUtils.ln_s "#{CREW_PREFIX}/firefox/firefox", "#{CREW_DEST_PREFIX}/bin/firefox"
  end
end
