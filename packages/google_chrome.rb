require 'package'

class Google_chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome/'
  version '147.0.7727.101'
  license 'google-chrome'
  compatibility 'x86_64'
  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_#{version}-1_amd64.deb"
  source_sha256 '554e3571790207f254d9ad5b5c718c41517c64af7967b14123afa4e728cf6fcd'

  no_compile_needed
  no_shrink

  depends_on 'alsa_lib' => :executable
  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'cras' => :logical
  depends_on 'cups' => :executable
  depends_on 'dbus' => :executable
  depends_on 'eudev' => :executable
  depends_on 'expat' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :executable
  depends_on 'glibc' # R
  depends_on 'harfbuzz' => :executable
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' => :executable
  depends_on 'libxdamage' => :executable
  depends_on 'libxext' # R
  depends_on 'libxfixes' => :executable
  depends_on 'libxkbcommon' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'mesa' => :executable
  depends_on 'nss' => :executable
  depends_on 'pango' => :executable

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/google/chrome', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s "#{CREW_PREFIX}/share/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Chrome', 'google-chrome')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Chrome', 'google-chrome')
  end
end
