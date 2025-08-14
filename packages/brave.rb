require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.81.135'
  license 'MPL-2'
  compatibility 'x86_64'

  source_url 'https://brave-browser-apt-release.s3.brave.com/pool/main/b/brave-browser/brave-browser_1.81.135_amd64.deb'
  source_sha256 '33df4b1743dcef8c6c4269c7f7b013094c6b03215f890d11c3c29822f909a0f7'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brave/brave", "#{CREW_DEST_PREFIX}/bin/brave"
    FileUtils.ln_s CREW_LIB_PREFIX, "#{CREW_DEST_PREFIX}/share/#{ARCH_LIB}"
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Brave', 'brave')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Brave', 'brave')
  end
end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Brave', 'brave')
  end
end
