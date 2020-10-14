require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '71.0.3770.198'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    depends_on 'alien' => :build
    depends_on 'gtk3'
    depends_on 'sommelier'
    depends_on 'gsettings_desktop_schemas'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/opera-71.0.3770.198-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '826b9da7012782f422196509033f7ba0068bd7d885e0984d709d222bdbe1718d',
  })

  def self.build
    system "wget https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("opera-stable_#{version}_amd64.deb") ) == 'd44af29613a8eb00ea54e63a74ce48d601131b239e191c695cc6124bb746a00f'
    system "alien -tc opera-stable_#{version}_amd64.deb"
    system "tar xvf opera-stable-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/lib', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
