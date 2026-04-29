require 'package'

class Cursor < Package
  description 'The AI Code Editor'
  homepage 'https://www.cursor.com/'
  version '3.2.11'
  license 'Cursor EULA'
  compatibility 'x86_64'
  # Download links can be found at https://cursor.uuid.site/
  source_url 'https://downloads.cursor.com/production/e9ee1339915a927dfb2df4a836dd9c8337e17cc2/linux/x64/Cursor-3.2.11-x86_64.AppImage'
  source_sha256 'c51b6b06fca11bdeea1f3653b9f88475f4481722164afa1d2205f927d4e8356a'

  no_compile_needed
  no_shrink

  depends_on 'gdk_base'
  depends_on 'gtk3'
  depends_on 'sommelier' => :logical

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
