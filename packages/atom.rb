require 'package'

class Atom < Package
  description 'The hackable text editor'
  homepage 'https://atom.io/'
  version '1.43.0'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/atom-1.43.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '435736336fa7d108a318b11ebe92fc7266abf0b14ee59fd8d2890a722483cb01',
  })

  depends_on 'alien' => :build
  depends_on 'fakeroot'
  depends_on 'gtk3'
  depends_on 'libsecret'
  depends_on 'sommelier'

  def self.build
    system "wget https://github.com/atom/atom/releases/download/v#{version}/atom-amd64.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('atom-amd64.deb') ) == 'ce3af452301b6ad45ee0abf340e497f8778f6fae114be9e455a305045ab3a037'
    system "alien -tc atom-amd64.deb"
    system "tar xvf atom-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
