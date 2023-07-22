require 'package'
 
class Musescore < Package
  description "The world's most popular notation app"
  homepage 'musescore.org'
  version '4.0.2'
  license 'GPL-3'
  compatibility 'aarch64, x86_64'
  source_url 'https://musescore.org/en/download/musescore-x86_64.AppImage'
  source_sha256 'f9a54ad7caf8d2173d67e972ffa68b750bf149f34f4b07d59cbc96dc2c663c79'
 
  depends_on 'crew-launcher'
  depends_on 'p7zip'
  depends_on 'sommelier'
  depends_on 'qtbase'
 
  def self.preflight
   free_space = `echo $(($(stat -f --format="%a*%S" #{CREW_PREFIX})))`.chomp.to_i
   abort 'Not enough free disk space.  You need at least 317 MB to install.'.lightred if free_space < 317000000
  end
  def self.install
  system("7z x musescore-x86_64.AppImage")
  FileUtils.mv 'bin' ,"#{CREW_DEST_PREFIX}"
  FileUtils.mv 'share' ,"#{CREW_DEST_PREFIX}"
  FileUtils.mv 'include' ,"#{CREW_DEST_PREFIX}"
  FileUtils.mv 'lib' ,"#{CREW_DEST_PREFIX}"
  end
  def self.postinstall
   FileUtils.mv 'plugins/*/*.so' ,"#{CREW_DEST_PREFIX}/lib64"
   system("crew-launcher start")
   system("crew-launcher add #{CREW_DEST_PREFIX}/share/applications/org.musescore.MuseScore4portable.desktop")
  end 
 def self.remove
  system("crew-launcher remove #{CREW_DEST_PREFIX}/share/applications/org.musescore.MuseScore4portable.desktop")
  end
end
