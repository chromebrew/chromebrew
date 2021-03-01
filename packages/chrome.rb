require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  compatibility 'x86_64'
  @_ver = '88.0.4324.182'
  @_deb = "google-chrome-stable_#{@_ver}-1_amd64.deb"
  version @_ver
  
  binary_url ({
    x86_64: "https://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/#{@_deb}"
  })
  binary_sha256 ({
    x86_64: 'ab00e9412f5f20e30c7db5dc987473248f4adf9ebf2c3f928ef62e1ffb104fe6'
  })
  
  is_external

  if ARCH == 'x86_64' then
    depends_on 'nspr'
    depends_on 'cairo'
    depends_on 'gtk3'
    depends_on 'expat'
    depends_on 'cras'
    depends_on 'sommelier'
  end

  def self.install
    ENV['CREW_NOT_STRIP'] = '1'
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mkdir_p 'bin'
    
    FileUtils.mv 'usr/share', 'share'
    FileUtils.rm_rf 'usr'
    
    FileUtils.ln_s "#{CREW_PREFIX}/opt/google/chrome/google-chrome", 'bin/google-chrome-stable'
    FileUtils.ln_s "#{CREW_PREFIX}/opt/google/chrome/google-chrome", 'bin/google-chrome'
    
    FileUtils.mv Dir.glob('*'), CREW_DEST_PREFIX
  end
end
