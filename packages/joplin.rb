require 'package'

class Joplin < Package
  description 'Open source note-taking app'
  homepage 'https://joplinapp.org/'
  version '3.6.4'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://objects.joplinusercontent.com/v#{version}/Joplin-#{version}.AppImage"
  source_sha256 '345f2824c318313905d1bcbb3d4fb39e6773b14d72178ca46fa3d329bf6f0290'

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
