require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '74.0.3911.154'
  compatibility 'x86_64'
  if ARCH == 'x86_64'
    source_url "https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb"
    source_sha256 `curl -Ls https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb.sha256sum`.chomp
    depends_on 'alien' => :build
    depends_on 'gtk3'
    depends_on 'gsettings_desktop_schemas'
    depends_on 'harfbuzz'
    depends_on 'graphite'
    depends_on 'cras'
    depends_on 'sommelier'
  end


  def self.build
    Dir.chdir('../') do
      system "alien -tc opera-stable_#{version}_amd64.deb"
      system "tar xf opera-stable-#{version}.tgz"
    end
  end

  def self.install
    Dir.chdir('../') do
      # llvm-strip doesn't works with opera
      ENV['CREW_NOT_STRIP'] = '1'
      FileUtils.mkdir_p CREW_DEST_PREFIX
      FileUtils.mv Dir.glob('usr/*'), CREW_DEST_PREFIX
      FileUtils.ln_s "#{CREW_PREFIX}/bin/opera", "#{CREW_DEST_PREFIX}/bin/x-www-browser" unless File.exist?("#{CREW_PREFIX}/bin/x-www-browser")
    end
  end
end
