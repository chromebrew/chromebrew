require 'package'

class Minecraft < Package
  description 'A sandbox video game developed by Mojang Studios AB.'
  homepage 'https://minecraft.net'
  version '2.2.3200'
  license 'Mojang'
  compatibility 'x86_64'
  source_url 'https://launcher.mojang.com/download/Minecraft.deb'
  # The minecraft-launcher deb changes often, and we are downloading via https
  # so maybe it is ok to trust the source package without further hashing.
  source_sha256 'SKIP'

  depends_on 'libx11'
  depends_on 'openjdk17'
  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'libsecret'
  depends_on 'sommelier'

  no_fhs

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/minecraft-launcher", "#{CREW_DEST_PREFIX}/bin/minecraft-launcher.elf"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.minecraft"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      @launcherscript = <<~EOF
        #!/bin/bash
        # Minecraft launcher documentation is at:
        # https://minecraft.fandom.com/wiki/Minecraft_Launcher
        HOME=#{CREW_PREFIX}/.config #{CREW_PREFIX}/bin/minecraft-launcher.elf --workDir #{CREW_PREFIX}/.config/.minecraft --tmpDir #{CREW_PREFIX}/tmp $@
      EOF
      File.write('minecraft-launcher', @launcherscript, perm: 0o755)
    end
  end

  def self.postinstall
    puts
    puts "Your minecraft data is in #{CREW_PREFIX}/.config/.minecraft .".lightblue
    puts 'To launch, just type `minecraft-launcher`.'.lightblue
    puts
  end
end
