require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '4.8.5'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  source_url 'https://updates.tdesktop.com/tlinux/tsetup.4.8.5.tar.xz'
  source_sha256 'e4f13c564fbb643cdf81a9da9d88f31a16e99a44f37d5df68e63a26b42fa4d27'

  depends_on 'mesa'

  no_compile_needed

  def self.build
    telegram = <<~EOF
      #!/bin/bash
      QT_QPA_PLATFORM=wayland-egl DISPLAY= WAYLAND_DISPLAY=wayland-0 Telegram "$@"
    EOF
    File.write('telegram', telegram)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'Telegram', "#{CREW_DEST_PREFIX}/bin/Telegram", mode: 0o755
    FileUtils.install 'telegram', "#{CREW_DEST_PREFIX}/bin/telegram", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'telegram' to get started.\n".lightblue
  end
end
