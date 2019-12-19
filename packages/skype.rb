require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/en/'
  version '8.55.0.141'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/skype-8.55.0.141-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    x86_64: '2d86530386eee57efd8a83848171d84cfefe9d1f31ebed133c699d25f074eef9'
  })

  depends_on 'alien' => :build
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    system 'wget https://go.skype.com/skypeforlinux-64.deb'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('skypeforlinux-64.deb') ) == '3ae2915428c94fccd7b86ee9e347812e0fd8d70c2883bb75865156e16ceecb79'
    system 'alien -t -c skypeforlinux-64.deb'
    system 'tar xvf skypeforlinux-8.55.0.141.tgz'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin/skypeforlinux', 'usr/bin/skype'
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
