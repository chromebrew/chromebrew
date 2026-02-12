require 'package'

class Joplin < Package
  description 'Open source note-taking app'
  homepage 'https://joplinapp.org/'
  version '3.6.2'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://objects.joplinusercontent.com/v#{version}/Joplin-#{version}.AppImage"
  source_sha256 '2674ade1a79c96d0db2ed9e20f7e70846d30c15a00a4958cfc134f7f4a1073a8'

  depends_on 'gtk3'
  depends_on 'gdk_base'
  depends_on 'libxss'
  depends_on 'libxtst'
  depends_on 'sommelier' => :logical

  no_compile_needed
  no_shrink

  def self.build
    File.write 'joplin.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/joplin
      ./AppRun "$@"
    EOF
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
