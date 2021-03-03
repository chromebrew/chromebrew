require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '74.0.3911.160'
  compatibility 'x86_64'
  version '74.0.3911.160'
  
  is_external
  
  if ARCH == 'x86_64'
    depends_on 'gtk3'
    depends_on 'gsettings_desktop_schemas'
    depends_on 'harfbuzz'
    depends_on 'graphite'
    depends_on 'cras'
    depends_on 'sommelier'
    source_url "https://get.geo.opera.com/pub/opera/desktop/74.0.3911.160/linux/opera-stable_#{version}_amd64.deb"
    source_sha256 `curl -Ls https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb.sha256sum`.chomp
  end

  def self.install
    # llvm-strip doesn't works with opera
    ENV['CREW_NOT_STRIP'] = '1'
    
    # since opera put the executable to library, we need to link it to CREW_PREFIX
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/opera/opera", 'bin/opera'
      
    # place all stuff to lib64 instead of lib
    FileUtils.mv 'lib/x86_64-linux-gnu/', 'share/'
    FileUtils.rm_rf 'lib/'
    
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir.glob('*'), CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/opera/opera", "#{CREW_DEST_PREFIX}/bin/x-www-browser" unless File.exist?("#{CREW_PREFIX}/bin/x-www-browser")
  end
end
