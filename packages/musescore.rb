require 'package'
 
class Musescore < Package
  description "The world's most popular notation app"
  homepage 'musescore.org'
  version '4.1.0'
  license 'GPL-3'
  compatibility 'aarch64, x86_64'
  source_url 'https://github.com/musescore/MuseScore/releases/download/v4.1.0/MuseScore-4.1.0.231921359-x86_64.AppImage'
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
  FileUtils.mv 'squashfs-root/bin' ,"#{CREW_DEST_PREFIX}"
  FileUtils.mv 'squashfs-root/share' ,"#{CREW_DEST_PREFIX}"
  FileUtils.mv 'squashfs-root/include' ,"#{CREW_DEST_PREFIX}"
  FileUtils.mv 'squashfs-root/lib' ,"#{CREW_DEST_PREFIX}"
  end
  def self.postinstall
   FileUtils.mv 'squashfs-root/plugins/*/*.so' ,"#{CREW_DEST_PREFIX}/lib64"
  end 
 def self.remove
  end
end
