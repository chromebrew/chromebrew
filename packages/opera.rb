require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '72.0.3815.400'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    depends_on 'alien' => :build
    depends_on 'gtk3'
    depends_on 'gsettings_desktop_schemas'
    depends_on 'harfbuzz'
    depends_on 'graphite'
    depends_on 'sommelier'
  end


  def self.build
    system "curl https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb -#o opera.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("opera.deb") ) == `curl -Ls https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb.sha256sum`
    puts "Archive downloaded".lightgreen
    system "alien -tc opera.deb"
    system "tar xvf opera-stable-#{version}.tgz > /dev/null"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/bin', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/lib', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/opera", "#{CREW_DEST_PREFIX}/bin/x-www-browser"
  end
end
