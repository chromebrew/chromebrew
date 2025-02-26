require 'package'

class Google_webdesigner < Package
  description 'Google Web Designer'
  homepage 'https://webdesigner.withgoogle.com/'
  version '14.2.1.0-1'
  license 'google-webdesigner'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://dl.google.com/linux/webdesigner/deb/pool/main/g/google-webdesigner/google-webdesigner_#{version}_amd64.deb"
  source_sha256 'c5f8448248a810255e29dcd7ed11a33b653aeb646c6239b9c760b88b184ce4af'

  depends_on 'nss'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'
  depends_on 'lsb_release'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX.to_s
    FileUtils.mv 'opt/google/webdesigner', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s '../share/webdesigner/webdesigner', "#{CREW_DEST_PREFIX}/bin/webdesigner-stable"
    FileUtils.ln_s '../share/webdesigner/webdesigner', "#{CREW_DEST_PREFIX}/bin/webdesigner"
  end

  def self.postinstall
    ExitMessage.add "\nType 'webdesigner' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.local/share/google-web-designer")
  end
end
