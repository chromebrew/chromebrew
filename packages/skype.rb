require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.65.0.78'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    depends_on 'alien' => :build
    depends_on 'gtk3'
    depends_on 'sommelier'
  end

  def self.build
    system 'curl https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_8.65.0.78_amd64.deb -#o skype.deb'
    puts "Archive downloaded".lightgreen
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('skype.deb') ) == '9026f043697d7d0783e7232701a868229d9a91e91dc0ae86509732c1c7bf0c13'
    system 'alien -tc skype.deb'
    system "tar xvf skypeforlinux-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/skypeforlinux", "#{CREW_DEST_PREFIX}/bin/skype"
  end
end
