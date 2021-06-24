require 'package'

class Minecraft < Package
  description 'A sandbox video game developed by Mojang Studios AB.'
  homepage 'https://minecraft.net'
  version '2.2.3200'
  license 'Mojang'
  compatibility 'x86_64'
  source_url 'https://launcher.mojang.com/download/Minecraft.deb'
  source_sha256 '21254b54e59e946adc523898f704592dc7c32b644c618324df80c4b98355ccd0'

  depends_on 'libx11'
  depends_on 'jdk8'
  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/minecraft-launcher", "#{CREW_DEST_PREFIX}/bin/minecraft-launcher.elf"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/minecraft"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      @launcherscript = <<~EOF
        #!/bin/bash
        # Minecraft launcher documentation is at:
        # https://minecraft.fandom.com/wiki/Minecraft_Launcher
        sudo mount -o remount,symfollow /home/chronos/user
        /usr/local/bin/minecraft-launcher.elf --disableGPU --workDir #{CREW_PREFIX}/.config/minecraft --tmpDir #{CREW_PREFIX}/tmp $@
        sudo mount -o remount,nosymfollow /home/chronos/user
      EOF
      IO.write("minecraft-launcher", @launcherscript)
      system "chmod +x minecraft-launcher"
    end
  end

  def self.postinstall
    puts
    puts "Your minecraft data is in #{CREW_PREFIX}/.config/minecraft and ~/.minecraft .".lightblue
    puts "To launch, just type `minecraft-launcher`.".lightblue
    puts
  end
end
