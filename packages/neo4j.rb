require 'package'
require 'misc_functions'

class Neo4j < Package
  description "The world's most-loved graph database"
  homepage 'https://neo4j.com/'
  version '2.0.2'
  license 'Neo4j Desktop License Agreement'
  compatibility 'x86_64'
  source_url "https://dist.neo4j.org/neo4j-desktop-2/linux/neo4j-desktop-#{version}-x86_64.AppImage"
  source_sha256 'f20b808613087ed4f5924e1559f2712bd6dbdbc4c98b1bfa4b63f5157c133e50'

  no_compile_needed
  no_shrink
  gnome

  depends_on 'gtk3'
  depends_on 'sommelier'
  depends_on 'xdg_base'

  def self.preflight
    # Need at least 1.7 gb of free disk space.
    MiscFunctions.check_free_disk_space(1825361100)
  end

  def self.patch
    system "sed -i 's,AppRun,neo4j,' neo4j-desktop.desktop"
  end

  def self.build
    File.write 'neo4j.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/neo4j
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/neo4j"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'neo4j-desktop.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'neo4j.sh', "#{CREW_DEST_PREFIX}/bin/neo4j", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/neo4j"
  end

  def self.postinstall
    ExitMessage.add "\nType 'neo4j' to get started.\n".lightblue
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/neo4j-desktop")
  end
end
