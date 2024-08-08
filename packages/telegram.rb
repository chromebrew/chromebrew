require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '5.3.0'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://updates.tdesktop.com/tlinux/tsetup.#{version}.tar.xz"
  source_sha256 'b9dc4cbbba4d65d7d7a46d03bb21ee8bdcf90582877b9a4d2f02f5157251346d'

  depends_on 'mesa'

  no_compile_needed
  no_shrink

  def self.build
    File.write 'telegram', <<~EOF
      #!/bin/bash
      DISPLAY=
      GDK_BACKEND=wayland
      WAYLAND_DISPLAY=wayland-0
      QT_QPA_PLATFORM=wayland-egl
      Telegram "$@"
    EOF
  end

  def self.install
    FileUtils.install 'Telegram', "#{CREW_DEST_PREFIX}/bin/Telegram", mode: 0o755
    FileUtils.install 'telegram', "#{CREW_DEST_PREFIX}/bin/telegram", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'telegram' to get started.\n".lightblue
  end
end
