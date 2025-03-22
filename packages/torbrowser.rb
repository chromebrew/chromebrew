require 'package'
require 'convenience_functions'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  version '14.0.7'
  license 'BSD, custom, MPL-2.0 and MIT'
  compatibility 'x86_64'
  source_url "https://dist.torproject.org/torbrowser/#{version}/tor-browser-linux-x86_64-#{version}.tar.xz"
  source_sha256 '091a56fb506a35e2e507272a3335a9e1c597a9a87ce637f83cb8446e8d14b03a'

  depends_on 'gtk3'
  depends_on 'gdk_base'

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.patch
    system "sed -i 's,$(pwd),#{CREW_PREFIX}/share/torbrowser,g' start-tor-browser.desktop"
    system "sed -i 's,./Browser,#{CREW_PREFIX}/share/torbrowser/Browser,' start-tor-browser.desktop"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/torbrowser"
    FileUtils.mv 'Browser/', "#{CREW_DEST_PREFIX}/share/torbrowser"
    FileUtils.mv 'start-tor-browser.desktop', "#{CREW_DEST_PREFIX}/share/torbrowser"
    FileUtils.ln_s "#{CREW_PREFIX}/share/torbrowser/start-tor-browser.desktop", "#{CREW_DEST_PREFIX}/bin/tor"
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Tor', 'tor')
    ExitMessage.add "\nType 'tor' to get started.\n"
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Torbrowser', 'start-tor-browser.desktop')
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/share/torbrowser")
  end
end
