require 'package'

class Deskreen < Package
  description 'Turn any device into a secondary screen for your computer'
  homepage 'https://deskreen.com/lang-en'
  version '2.0.4'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/pavlobu/deskreen/releases/download/v#{version}/Deskreen-#{version}.AppImage"
  source_sha256 'd2323f99b5da5da9d8e9acb6ce7f9d3d61afb2a591705f1a60746f7c656c39b1'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,AppRun --no-sandbox,deskreen,' deskreen.desktop"
    system "sed -i '24iAPPDIR=#{CREW_PREFIX}/share/deskreen' AppRun"
  end

  def self.build
    File.write 'deskreen.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/deskreen
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/deskreen"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'deskreen.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'deskreen.sh', "#{CREW_DEST_PREFIX}/bin/deskreen", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/deskreen"
  end

  def self.postinstall
    ExitMessage.add "\nType 'deskreen' to get started.\n"
  end
end
