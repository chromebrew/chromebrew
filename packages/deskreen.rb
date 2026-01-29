require 'package'

class Deskreen < Package
  description 'Turn any device into a secondary screen for your computer'
  homepage 'https://deskreen.com/lang-en'
  version '3.2.1'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/pavlobu/deskreen/releases/download/v#{version}/deskreen-ce-#{version}-x86_64.AppImage"
  source_sha256 'caecfa17fb135a01fc600ef5d01c6c08d4cc6175270bef9ff0371e7e6ba092f3'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'sommelier' => :logical

  def self.patch
    system "sed -i 's,AppRun --no-sandbox,deskreen,' deskreen-ce.desktop"
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/deskreen"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'deskreen-ce.png', "#{CREW_DEST_PREFIX}/share/icons"
    FileUtils.mv 'deskreen-ce.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'deskreen.sh', "#{CREW_DEST_PREFIX}/bin/deskreen", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/deskreen"
  end

  def self.postinstall
    ExitMessage.add "\nType 'deskreen' to get started.\n"
  end
end
