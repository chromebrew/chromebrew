require 'package'

class Magic < Package
  description 'Magic is a venerable VLSI layout tool'
  homepage 'http://opencircuitdesign.com/magic/'
  version '8.3.486'
  license 'Copyright (C) 1985, 1990 Regents of the University of California'
  compatibility 'x86_64'
  source_url "https://github.com/RTimothyEdwards/magic/releases/download/#{version}/Magic-#{version}-x86_64.AppImage"
  source_sha256 '6f67fff17e4a091e633d157fa4b1dec6d96f3b4dddadc5b4d825d13834257e99'

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
