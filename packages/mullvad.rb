require 'package'
require 'convenience_functions'

class Mullvad < Package
  description 'Privacy-focused browser'
  homepage 'https://mullvad.net/browser'
  version '14.0.5'
  license 'Mozilla Public License V2'
  compatibility 'x86_64'
  source_url "https://github.com/mullvad/mullvad-browser/releases/download/#{version}/mullvad-browser-linux-x86_64-#{version}.tar.xz"
  source_sha256 'cbdf08cc29e88db0430e3e8f71bc6d4cfc1f1c0e30669c3a835aad992824a450'

  depends_on 'gtk3'
  depends_on 'gdk_base'

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.patch
    system "sed -i 's,\",,g' Browser/start-mullvad-browser.desktop"
    system "sed -i 's,\\$(dirname \\$\\*)/Browser,#{CREW_PREFIX}/share/mullvad,g' Browser/start-mullvad-browser.desktop"
    system "sed -i 's,\\$(dirname \\$\\*),#{CREW_PREFIX}/share/mullvad,g' Browser/start-mullvad-browser.desktop"
    system "sed -i 's,./Browser,#{CREW_PREFIX}/share/mullvad,g' Browser/start-mullvad-browser.desktop"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/mullvad"
    FileUtils.install 'Browser/start-mullvad-browser.desktop', "#{CREW_DEST_PREFIX}/share/applications/start-mullvad-browser.desktop", mode: 0o644
    FileUtils.install 'Browser/browser/chrome/icons/default/default64.png', "#{CREW_DEST_PREFIX}/share/icons/default/64x64/apps/web-browser.png", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/mullvad/start-mullvad-browser", "#{CREW_DEST_PREFIX}/bin/mullvad"
    FileUtils.mv Dir['Browser/*'], "#{CREW_DEST_PREFIX}/share/mullvad"
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Mullvad', 'mullvad')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Mullvad', 'start-mullvad-browser')
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/share/mullvad")
  end
end
