require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '4.12.2'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  source_url 'https://updates.tdesktop.com/tlinux/tsetup.4.12.2.tar.xz'
  source_sha256 '0b412e0d685d7bf85302d971c893a505e5eb05f0c39a6706566f230058f4ad40'

  depends_on 'mesa'

  no_compile_needed
  no_shrink

  def self.preflight
    if Gem::Version.new(LIBC_VERSION.to_s) < Gem::Version.new('2.29')
      puts "\nOpera requires GLIBC 2.29 and above.".lightred
      abort "ChromeOS is currently running GLIBC #{LIBC_VERSION}.\n".lightred
    end
  end

  def self.build
    telegram = <<~EOF
      #!/bin/bash
      DISPLAY=
      GDK_BACKEND=wayland
      WAYLAND_DISPLAY=wayland-0
      QT_QPA_PLATFORM=wayland-egl
      Telegram "$@"
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
