require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '4.14.15'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url 'https://updates.tdesktop.com/tlinux/tsetup.4.14.15.tar.xz'
  source_sha256 'b463ba84b4f2caf71f73fa1a403dacfdc0eb0dde51fa50f392b55cd14ab08653'

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
