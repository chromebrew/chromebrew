require 'package'
 
class Musescore < Package
  description "The world's most popular notation app"
  homepage 'musescore.org'
  version '4.0.2'
  license 'GPL-3'
  compatibility 'aarch64, x86_64'
  source_url 'https://dl.flathub.org/repo/appstream/org.musescore.MuseScore.flatpakref'
  source_sha256 'e38b3a4c4dbe9027fc6c8e5e922c66c593b097b05e5daa1e2cfb021716931174'
 
  depends_on 'flatpak'
  depends_on 'crew-laucher'

  def self.preflight
  free_space = `echo $(($(stat -f --format="%a*%S" #{CREW_PREFIX})))`.chomp.to_i
  abort 'Not enough free disk space.  You need at least 317 MB to install.'.lightred if free_space < 317000000
  def self.install
  system("flatpak install ./org.musescore.MuseScore.flatpakref -y")
  end

  def self.postinstall
  end
end
