require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/en/'
  version '8.56.0.103'
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
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/skype-8.56.0.103-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '1670a0c74ac08b224034aefbd27f3d03b89529e7168dc84ac095944a1aa93736',
  })

  def self.build
    system 'wget https://go.skype.com/skypeforlinux-64.deb'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('skypeforlinux-64.deb') ) == '20b1b1b85c76cac9d224dccf5748cf21f954fe1a36c98fd5a7aa13d8448a1e07'
    system 'alien -tc skypeforlinux-64.deb'
    system "tar xvf skypeforlinux-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin/skypeforlinux', 'usr/bin/skype'
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
