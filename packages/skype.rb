require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.68.76.35'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    depends_on 'alien' => :build
    depends_on 'gtk3'
    depends_on 'sommelier'
  end

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/skype-8.68.76.35-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: 'a81fe08610a71e5b3f1b9d45384c58a405ec6c94f36a88ec0dd7d257240feb26',
  })

  def self.build
    system 'curl https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_8.68.76.35_amd64.deb -#o skype.deb'
    puts "Archive downloaded".lightgreen
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('skype.deb') ) == '701449b86ff1c10ee800cc017033c7c2e9b31023fcc1a9058590babf070ce3bb'
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
