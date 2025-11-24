require 'package'

class Joplin < Package
  description 'Open source note-taking app'
  homepage 'https://joplinapp.org/'
  version '3.5.7'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://objects.joplinusercontent.com/v#{version}/Joplin-#{version}.AppImage"
  source_sha256 'b874d9319c3f46d060c088eff99e462ad79e6c2bf90b789a1078f4a6eec43fe7'

  depends_on 'gtk3'
  depends_on 'gdk_base'
  depends_on 'libxss'
  depends_on 'libxtst'
  depends_on 'sommelier'

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
