require 'package'

class Cursor < Package
  description 'The AI Code Editor'
  homepage 'https://www.cursor.com/'
  version '1.4.5'
  license 'Cursor EULA'
  compatibility 'x86_64'
  # Download links can be found at https://github.com/oslook/cursor-ai-downloads
  source_url 'https://downloads.cursor.com/production/af58d92614edb1f72bdd756615d131bf8dfa5299/linux/x64/Cursor-1.4.5-x86_64.AppImage'
  source_sha256 'd87cf5b570be6242081d61b59cedfff38a32807fb0bda52d4d7aafbf5f59033e'

  no_compile_needed
  no_shrink

  depends_on 'gdk_base'
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,AppRun,cursor,' cursor.desktop"
  end

  def self.build
    File.write 'cursor.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/cursor
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.install 'cursor.desktop', "#{CREW_DEST_PREFIX}/share/applications/cursor.desktop", mode: 0o644
    FileUtils.install 'cursor.sh', "#{CREW_DEST_PREFIX}/bin/cursor", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/cursor"
  end

  def self.postinstall
    ExitMessage.add "\nType 'cursor' to get started.\n"
  end
end
