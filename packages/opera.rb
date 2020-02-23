require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '66.0.3515.103'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/opera-66.0.3515.103-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: 'b128d632850931f8c4eb49a532c7350ccdadeb1746fc8ca95c9c1f06eff2cc69',
  })

  depends_on 'alien' => :build
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    system "wget https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("opera-stable_#{version}_amd64.deb") ) == '6d561ef2bb8383bf3181d2e51343d94dfd1c71941da21c703d2064b3f424e9a0'
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
