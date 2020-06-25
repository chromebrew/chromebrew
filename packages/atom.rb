require 'package'

class Atom < Package
  description 'The hackable text editor'
  homepage 'https://atom.io/'
  version '1.48.0'
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
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/atom-1.48.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '0ec7fd1c4aa6c2451c02f6c294e37063b84b1bb97e921c9dee65e99c64ee19e5',
  })

  def self.build
    system "wget https://github.com/atom/atom/releases/download/v#{version}/atom-amd64.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('atom-amd64.deb') ) == '41a717bb3749a77f1b55f9262417c5dc8cf9e22d99b5951a85d238ea575f2399'
    system "alien -tc atom-amd64.deb"
    system "tar xvf atom-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
