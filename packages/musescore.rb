require 'package'
 
class Musescore < Package
  description "The world's most popular notation app"
  homepage 'musescore.org'
  version '4.1.0'
  license 'GPL-3'
  compatibility 'aarch64, x86_64'
  source_url 'https://raw.githubusercontent.com/Franceschinie/musescore/main/install.sh'
  source_sha256 'f9a54ad7caf8d2173d67e972ffa68b750bf149f34f4b07d59cbc96dc2c663c79'
 
  depends_on 'p7zip'
  depends_on 'sommelier'
  depends_on 'qtbase'

 no_compile_needed
 
  def self.preflight
   free_space = `echo $(($(stat -f --format="%a*%S" #{CREW_PREFIX})))`.chomp.to_i
   abort 'Not enough free disk space.  You need at least 317 MB to install.'.lightred if free_space < 317000000
  end
  def self.install
system("sudo bash ./install.sh")
  end
  def self.postinstall
  end 
 def self.remove
  end
end
