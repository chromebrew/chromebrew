require 'package'

class Joplin < Package
  description 'Open source note-taking app'
  homepage 'https://joplinapp.org/'
  version '3.1.20'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://objects.joplinusercontent.com/v#{version}/Joplin-#{version}.AppImage"
  source_sha256 '707af1da50c7b76d686e9d5f764d195d30ae02208b60879a14d344762851aff6'

  depends_on 'gtk3'
  depends_on 'gdk_base'
  depends_on 'libxss'
  depends_on 'libxtst'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.build
    joplin = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/joplin
      ./AppRun "$@"
    EOF
    File.write('joplin.sh', joplin)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/joplin"
    FileUtils.install 'joplin.sh', "#{CREW_DEST_PREFIX}/bin/joplin", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/joplin"
  end

  def self.postinstall
    ExitMessage.add "\nType 'joplin' to get started.\n"
  end
end
