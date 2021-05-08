require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '2.7.4'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  source_url 'https://updates.tdesktop.com/tlinux/tsetup.2.7.4.tar.xz'
  source_sha256 '3ea84c51f58654780a84cc56e1643cf9979e85657b6aab80cb2a69a237de8e6e'

  def self.build
    telegram = <<~EOF
    #!/bin/bash
    QT_QPA_PLATFORM=wayland-egl DISPLAY= WAYLAND_DISPLAY=wayland-0 Telegram "$@"
    EOF
    IO.write('telegram', telegram)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'Telegram', "#{CREW_DEST_PREFIX}/bin/Telegram", mode: 0o755
    FileUtils.install 'telegram', "#{CREW_DEST_PREFIX}/bin/telegram", mode: 0o755
  end

  def self.postinstall
    puts
    puts "Type 'telegram' to get started.".lightblue
    puts
  end
end
