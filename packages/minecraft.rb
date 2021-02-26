require 'package'

class Minecraft < Package
  description 'A sandbox video game developed by Mojang Studios AB.'
  homepage 'https://minecraft.net'
  version '2.2.1867'
  compatibility 'x86_64'
  source_url 'https://launcher.mojang.com/download/Minecraft.deb'
  source_sha256 '9a8b6b75db199461ae241fbee6adf65fc6636204c58eb79feff968e307464727'

  depends_on 'libx11'
  depends_on 'jdk8'
  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'sommelier'
  
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'opt', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r 'usr/share', "#{CREW_DEST_PREFIX}"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      @launcherscript = <<~EOF
        #!/bin/bash
        if [[ ! -e /usr/local/.config/minecraft ]]; then 
          mkdir -pv /usr/local/.config/minecraft
        fi
        if [[ ! -e $HOME/.var/app/com.mojang.Minecraft ]]; then
          mkdir -pv $HOME/.var/app/com.mojang.Minecraft
        fi
        if [[ -e $HOME/.minecraft ]]; then
          if [[ ! -L $HOME/.minecraft ]]; then 
            cp -rv $HOME/.minecraft/* /usr/local/.config/minecraft
            rm -r $HOME/.minecraft
            ln -sv /usr/local/.config/minecraft $HOME/.minecraft 
          fi
        else
          ln -sv /usr/local/.config/minecraft $HOME/.minecraft 
        fi
        if [[ -e $HOME/.var/app/com.mojang.Minecraft/.minecraft ]]; then
          if [[ ! -L $HOME/.var/app/com.mojang.Minecraft/.minecraft ]]; then
            cp -rv $HOME/.var/app/com.mojang.Minecraft/.minecraft/* /usr/local/.config/minecraft
            rm -r $HOME/.var/app/com.mojang.Minecraft/.minecrft 
            ln -sv /usr/local/.config/minecraft $HOME/.var/app/com.mojang.Minecraft/.minecraft 
          fi
        else
          ln -s /usr/local/.config/minecraft $HOME/.var/app/com.mojang.Minecraft/.minecraft 
        fi
        /usr/local/opt/minecraft-launcher/minecraft-launcher
      EOF
      IO.write("minecraft-launcher", @launcherscript)
      system "chmod +x minecraft-launcher"
    end
  end
  
  def self.postinstall
    puts
    puts "Your minecraft data is in the usual place, ~/.minecraft.".lightblue
    puts "To launch, just type `minecraft-launcher`.".lightblue
    puts
  end
end
