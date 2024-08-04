require 'package'

class Google_chrome_beta < Package
  @update_channel = 'beta'
  description 'Google Chrome is a fast, easy to use, and secure web browser. (Beta Channel)'
  homepage 'https://www.google.com/chrome/'
  version '128.0.6613.18-1'
  license 'google-chrome'
  compatibility 'x86_64'
  min_glibc '2.25'
  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-#{@update_channel}/google-chrome-#{@update_channel}_#{@version}_amd64.deb"
  source_sha256 'ca9bce2d3c8b6b2e092f28a73af01e7d95de093108ab40609e0390d0dd1a4ba3'

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
