require 'package'

class Picocad < Package                 # The first character of the class name must be upper case
  description 'picoCAD is a program to build and texture lowpoly 3D models. Where many programs for modelling and texturing are bloated and overly complicated, picoCAD aims to make it fun, easy, and accessible by focusing on the bare essentials. It is built on the PICO-8 platform and comes rich with constraints. Experiment to find your own workflow and anything is possible!'
  homepage 'https://johanpeitz.itch.io/picocad'
  version '1.07.1'
  compatibility 'all'
  depends_on 'sommelier'            # packages required by this package
  depends_on 'libx11'            # packages required by this package
  source_url 'https://cdn.discordapp.com/attachments/768193037708558427/823684213093171220/picocad-101.zip'
  source_sha256 '13da7c39d4c78d4878bc00fbe59ac3865852c60b4ad72b97cfd33f5619b6feb6'   # Use the command "sha256sum"

  def self.install                 # the steps required to install the package
    system "install picocad-101.bin/linux/picocad -Dt /usr/local/bin -m 755"
    system "install picocad-101.bin/linux/data.pod -Dt /usr/local/bin -m 755"	
  end

  def self.postinstall
    puts
    puts "Type `picocad` to run.".lightblue
    puts
  end

end
