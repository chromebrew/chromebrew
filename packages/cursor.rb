require 'package'

class Cursor < Package
  description 'The AI Code Editor'
  homepage 'https://www.cursor.com/'
  version '2.1.48'
  license 'Cursor EULA'
  compatibility 'x86_64'
  # Download links can be found at https://cursor.uuid.site/
  source_url 'https://downloads.cursor.com/production/ce371ffbf5e240ca47f4b5f3f20efed084991120/linux/x64/Cursor-2.1.48-x86_64.AppImage'
  source_sha256 '52aeb5659673951c83a8f68d9c96ed785438282f6eb03e437544931a0be8db02'

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
