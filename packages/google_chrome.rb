require 'package'

class Google_chrome < Package
  @update_channel = 'stable'
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome/'
  version '129.0.6668.100-1'
  license 'google-chrome'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-#{@update_channel}/google-chrome-#{@update_channel}_#{@version}_amd64.deb"
  source_sha256 'e4d2133a70c455de4f7b2593f6b3d5805bf95b96cfda1f9b2ccdf48639a9833b'

  depends_on 'nss'
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

    FileUtils.ln_s "#{CREW_PREFIX}/share/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end

  def self.postinstall
    ExitMessage.add "\nType 'google-chrome' to get started.\n"
  end
end
