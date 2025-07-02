require 'package'

class Termius < Package
  description 'Modern SSH Client'
  homepage 'https://termius.com/'
  version '9.25.1'
  license 'Apache-2.0, LGPL-2.1, MIT'
  compatibility 'x86_64'
  min_glibc '2.33'
  source_url 'https://www.termius.com/download/linux/Termius.deb'
  source_sha256 '8278abfc37764808c743f48a5caf2c0ab6eb175708d694bc05ae2c5e7dc1208b'

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
