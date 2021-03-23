require 'package'

class Picocad < Package                 # The first character of the class name must be upper case
  description 'picoCAD is a program to build and texture lowpoly 3D models.'
  homepage 'https://johanpeitz.itch.io/picocad'
  version '1.0.1'
  compatibility 'all'
  license 'Proprietary'
  depends_on 'libx11'            # packages required by this package
  depends_on 'sommelier'            # packages required by this package
  depends_on 'libsdl2'
  source_url 'https://cdn.discordapp.com/attachments/768193037708558427/823684213093171220/picocad-101.zip'
  source_sha256 '13da7c39d4c78d4878bc00fbe59ac3865852c60b4ad72b97cfd33f5619b6feb6'   # Use the command "sha256sum"

  def self.install                 # the steps required to install the package
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'picocad-101.bin/linux/picocad', "#{CREW_DEST_PREFIX}/bin/picocad", mode:0755
    FileUtils.install 'picocad-101.bin/linux/data.pod', "#{CREW_DEST_PREFIX}/bin/data.pod", mode:0644
  end

  def self.postinstall
    puts
    puts "Type `picocad` to run.".lightblue
    puts
  end

end
