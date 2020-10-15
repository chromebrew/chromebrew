require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '71.0.3770.271'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    depends_on 'alien' => :build
    depends_on 'gtk3'
    depends_on 'gsettings_desktop_schemas'
    depends_on 'sommelier'
  end

  binary_url ({
    x86_64: 'http://download1525.mediafire.com/txdclyv3qd0g/ix1ewo821h6d14n/opera-71.0.3770.271-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: 'ee4449b99e5afe6ead245a5bb487fd7ec22552bf7a5076bc686d0eee758e1518',
  })

  def self.build
    system "wget https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("opera-stable_#{version}_amd64.deb") ) == 'cad630af33ce7d54de802abd9c360b19d330ef64759888da1ec03e5dd7e54f9a'
    system "sudo chmod -R 777 * "
    system "alien -tc opera-stable_#{version}_amd64.deb"
    system "sudo chmod -R 777 * "
    system "chmod -R +x *"
    system "tar xvf opera-stable-#{version}.tgz"
    system "sudo chmod -R 777 * "
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/lib', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
  end
end
