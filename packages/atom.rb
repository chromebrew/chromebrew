require 'package'

class Atom < Package
  description 'The hackable text editor'
  homepage 'https://atom.io/'
  version '1.46.0'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    depends_on 'alien' => :build
    depends_on 'fakeroot'
    depends_on 'gtk3'
    depends_on 'libsecret'
    depends_on 'sommelier'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/atom-1.46.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '547bad83d65d8e06ef3738562825230697ea1e99d336d5ca67a8e09dacf873ea',
  })

  def self.build
    system "wget https://github.com/atom/atom/releases/download/v#{version}/atom-amd64.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('atom-amd64.deb') ) == '1efdd2ab08a8290c98386868b98ed6415f833fc8107c1141233a60bc5e8f212b'
    system "alien -tc atom-amd64.deb"
    system "tar xvf atom-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
