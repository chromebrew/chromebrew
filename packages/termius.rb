require 'package'

class Termius < Package
  description 'Modern SSH Client'
  homepage 'https://termius.com/'
  version '9.19.1'
  license 'Apache-2.0, LGPL-2.1, MIT'
  compatibility 'x86_64'
  source_url 'https://www.termius.com/download/linux/Termius.deb'
  source_sha256 'adfd2a6539c546fab951983f6a2086a22bb5aeb9214637b8b721fb19fd0b0345'

  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.patch
    system "sed -i 's,/opt/Termius,#{CREW_PREFIX}/share/Termius,' usr/share/applications/termius-app.desktop"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/Termius', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s "#{CREW_PREFIX}/share/Termius/termius-app", "#{CREW_DEST_PREFIX}/bin/termius"
  end

  def self.postinstall
    ExitMessage.add "\nType 'termius' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/Termius")
  end
end
