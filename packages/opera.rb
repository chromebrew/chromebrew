require 'package'

class Opera < Package
  description "Opera isn't just a browser. It's an awesome browser."
  homepage 'https://www.opera.com/'
  version '74.0.3911.160'
  compatibility 'x86_64'
  
  case ARCH
  when 'x86_64'
    version '74.0.3911.160'
  when 'i686'
    version '45.0.2552.898'
  end
  
  binary_url ({
      i686: "https://deb.opera.com/opera-stable/pool/non-free/o/opera-stable/opera-stable_#{version}_i386.deb",
    x86_64: "https://get.geo.opera.com/pub/opera/desktop/74.0.3911.160/linux/opera-stable_#{version}_amd64.deb"
  })
  binary_sha256 ({
      i686: '0fd8497f914efc47eb1ef1c7ce052487e3ca0c4c5474f01ad7e721f6ea08fea8',
    x86_64: `curl -Ls https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb.sha256sum`.chomp
  })
  
  is_external
  
  if ARCH == 'x86_64'
    depends_on 'gtk3'
    depends_on 'gsettings_desktop_schemas'
    depends_on 'harfbuzz'
    depends_on 'graphite'
    depends_on 'cras'
    depends_on 'sommelier'
  end

  def self.install
    # llvm-strip doesn't works with opera
    ENV['CREW_NOT_STRIP'] = '1'
    
    if ARCH == 'x86_64' then
      # since opera put the executable to library, we need to link it to CREW_PREFIX
      # remove old symlink which link to /usr/lib/x86_64-linux-gnu/opera/opera
      FileUtils.rm_rf 'bin/opera'
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/opera/opera", 'bin/opera'
      
      # place all stuff to lib64 instead of lib
      FileUtils.mv 'lib/x86_64-linux-gnu/', 'lib64/'
      FileUtils.rm_rf 'lib/'
    end
    
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir.glob('*'), CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/bin/opera", "#{CREW_DEST_PREFIX}/bin/x-www-browser" unless File.exist?("#{CREW_PREFIX}/bin/x-www-browser")
  end
end
