require 'package'

class Google_chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome/'
  version '145.0.7632.75'
  license 'google-chrome'
  compatibility 'x86_64'
  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_#{version}-1_amd64.deb"
  source_sha256 'e21163461914451ab535774050f7ac4b7dadfcdc86f5e6fbf38fec5bbe439425'

  no_compile_needed
  no_shrink

  depends_on 'alsa_lib' => :executable_only
  depends_on 'at_spi2_core' => :executable_only
  depends_on 'cairo' => :executable_only
  depends_on 'cras' => :logical
  depends_on 'cups' => :executable_only
  depends_on 'dbus' => :executable_only
  depends_on 'eudev' => :executable_only
  depends_on 'expat' => :executable_only
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :executable_only
  depends_on 'glibc' # R
  depends_on 'harfbuzz' => :executable_only
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' => :executable_only
  depends_on 'libxdamage' => :executable_only
  depends_on 'libxext' # R
  depends_on 'libxfixes' => :executable_only
  depends_on 'libxkbcommon' => :executable_only
  depends_on 'libxrandr' => :executable_only
  depends_on 'mesa' => :executable_only
  depends_on 'nss' => :executable_only
  depends_on 'pango' => :executable_only

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
