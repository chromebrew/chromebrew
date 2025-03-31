require 'package'

class Dbeaver < Package
  description 'Free Universal Database Tool'
  homepage 'https://dbeaver.io'
  version '25.0.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/dbeaver/dbeaver/releases/download/#{version}/dbeaver-ce-#{version}-linux.gtk.x86_64.tar.gz"
  source_sha256 '0859d34dc8edcdadc7c3a649dfdc19fdafe5fe251e523a6e7fd7928b9691f4fd'

  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  no_compile_needed

  def self.patch
    system "sed -i 's,/usr/share/dbeaver-ce,#{CREW_PREFIX}/share/dbeaver,g' dbeaver-ce.desktop"
    system "sed -i 's,#{CREW_PREFIX}/share/dbeaver/dbeaver.png,dbeaver.png,' dbeaver-ce.desktop"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dbeaver"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons/hicolor/256x256/apps"
    FileUtils.mv 'dbeaver-ce.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'dbeaver.png', "#{CREW_DEST_PREFIX}/share/icons/hicolor/256x256/apps"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/dbeaver"
    FileUtils.ln_s "#{CREW_PREFIX}/share/dbeaver/dbeaver", "#{CREW_DEST_PREFIX}/bin/dbeaver"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dbeaver' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.local/share/DBeaverData")
  end
end
