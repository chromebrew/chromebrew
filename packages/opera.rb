require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '65.0.3467.69'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/opera-65.0.3467.69-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    x86_64: '3c9d6056db24f8c6250c7dd382e82e7bb8758678ceb6877630457b0edb730cb1'
  })

  depends_on 'alien' => :build
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    system "wget https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("opera-stable_#{version}_amd64.deb") ) == '337af6edaa5394f914dd4e5228e75c1f3ddc1f87564f13a3c5df44fff7487026'
    system "alien -t -c opera-stable_#{version}_amd64.deb"
    system "tar xvf opera-stable-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/lib', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
