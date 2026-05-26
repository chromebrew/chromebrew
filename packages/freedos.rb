require 'package'

class Freedos < Package
  description 'FreeDOS is a free DOS-compatible operating system.'
  homepage 'https://www.freedos.org/'
  version '1.4'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url "https://download.freedos.org/#{version}/FD#{version.sub('.', '')}-LiveCD.zip"
  source_sha256 '2020ff6bb681967fd6eff8f51ad2e5cd5ab4421165948cef4246e4f7fcaf6339'

  depends_on 'libjpeg_turbo'
  depends_on 'libsamplerate'
  depends_on 'wayland_protocols'
  depends_on 'hicolor_icon_theme'
  depends_on 'gtk3'
  depends_on 'qemu'

  no_compile_needed

  def self.preflight
    # Need 5 gb for x86_64 and 3.5 gb for arm.
    min_size = ARCH.eql?('x86_64') ? 5368709120 : 3758096384
    MiscFunctions.check_free_disk_space(min_size)
  end

  def self.build
    mb = nil
    loop do
      print "\nEnter the drive C: partition size (in MB): ".yellow
      mb = $stdin.gets.chomp.to_i
      break unless mb < 100

      puts 'Enter a number greater than or equal to 100.'.lightred
    end

    # See https://opensource.com/article/17/10/run-dos-applications-linux.
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/dosfiles"
    system "qemu-img create freedos.img #{mb}M"
    system "qemu-system-i386 -m 16 -k en-us -rtc base=localtime -device cirrus-vga -display gtk -hda freedos.img -cdrom FD#{version.sub('.', '')}LIVE.iso -boot order=d"
    File.write 'freedos', <<~EOF
      #!/bin/bash
      qemu-system-i386 -m 16 -k en-us -rtc base=localtime -device cirrus-vga -display gtk -hda $HOME/freedos.img -drive file=fat:rw:$HOME/dosfiles/ -boot order=c
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/dosfiles"
    File.write "#{CREW_DEST_HOME}/dosfiles/README", <<~EOF
      Add freedos files in this directory.
    EOF
    FileUtils.install 'freedos', "#{CREW_DEST_PREFIX}/bin/freedos", mode: 0o755
    FileUtils.install 'freedos.img', "#{CREW_DEST_HOME}/freedos.img", mode: 0o644
    FileUtils.install "FD#{version.sub('.', '')}LIVE.iso", "#{CREW_DEST_HOME}/FD#{version.sub('.', '')}LIVE.iso", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Type 'freedos' to start.

      Add files to #{HOME}/dosfiles.
    EOM
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/dosfiles")
  end
end
