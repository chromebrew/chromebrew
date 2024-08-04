require 'package'

class Google_chrome_unstable < Package
  @update_channel = 'unstable'
  description 'Google Chrome is a fast, easy to use, and secure web browser. (Dev Channel)'
  homepage 'https://www.google.com/chrome/'
  version '129.0.6628.3-1'
  license 'google-chrome'
  compatibility 'x86_64'
  min_glibc '2.25'
  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-#{@update_channel}/google-chrome-#{@update_channel}_#{@version}_amd64.deb"
  source_sha256 '04ecad6568443416e347833cd9733b9866bb5b0465e34a93d6442eb75bc51d26'

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
    FileUtils.mv "opt/google/chrome-#{@update_channel}", "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s "../share/chrome/google-chrome-#{@update_channel}", "#{CREW_DEST_PREFIX}/bin/google-chrome-#{@update_channel}"
  end

  def self.postinstall
    ExitMessage.add "\nType 'google-chrome-#{@update_channel}' to get started.\n".lightblue
  end
end
