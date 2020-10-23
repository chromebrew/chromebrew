require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '72.0.3815.148'
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


  def self.build
    system "wget https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb"
    system "alien -tc opera-stable_#{version}_amd64.deb"
    system "tar xvf opera-stable-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/lib', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
    system "echo 'if [[ $(ls /usr/bin/ | grep x-www-browser) = x-www-browser ]]; then echo x-www-browser is already set; else sudo ln -s #{CREW_PREFIX}/bin/opera /usr/bin/x-www-browser; fi' > script.la.tmp"
    system "bash script.la.tmp"
  end
end
