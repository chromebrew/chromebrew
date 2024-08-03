require 'package'

class Google_chrome < Package
  @update_channel = 'stable'
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome/'
  version '127.0.6533.88-1'
  license 'google-chrome'
  compatibility 'x86_64'
  min_glibc '2.25'
  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-#{@update_channel}/google-chrome-#{@update_channel}_#{@version}_amd64.deb"
  source_sha256 'd25f5c89d3453b475ccb35b2e270c3fce18540304b5f1f5a3d5aba8a80e4a8ad'

  depends_on 'nspr'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/google/chrome', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s "../share/chrome/google-chrome-#{@update_channel}", "#{CREW_DEST_PREFIX}/bin/google-chrome-#{@update_channel}"
    FileUtils.ln_s "../share/chrome/google-chrome-#{@update_channel}", "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end

  def self.postinstall
    ExitMessage.add "\nType 'google-chrome-#{@update_channel}' to get started.\n".lightblue
  end
end
