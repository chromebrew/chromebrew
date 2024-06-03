require 'package'

class Magic < Package
  description 'Magic is a venerable VLSI layout tool'
  homepage 'http://opencircuitdesign.com/magic/'
  version '8.3.485'
  license 'Copyright (C) 1985, 1990 Regents of the University of California'
  compatibility 'x86_64'
  source_url 'https://github.com/RTimothyEdwards/magic/releases/download/8.3.485/Magic-8.3.485-x86_64.AppImage'
  source_sha256 '4eec89f36fc4415d2b56687fd5408817769cc383a7278fc40af7b9d764e994fc'

  no_compile_needed

  depends_on 'gtk3'

  def self.build
    File.write 'magic.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/magic
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/magic"
    FileUtils.install 'magic.sh', "#{CREW_DEST_PREFIX}/bin/magic", mode: 0o755
    FileUtils.mv 'man', "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'magic.desktop', "#{CREW_DEST_PREFIX}/share/applications/magic.desktop", mode: 0o644
    FileUtils.install 'magic.svg', "#{CREW_DEST_PREFIX}/share/icons/hicolor/magic.svg", mode: 0o644
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/magic"
  end

  def self.postinstall
    ExitMessage.add "\nType 'magic' to get started.\n".lightblue
  end
end
