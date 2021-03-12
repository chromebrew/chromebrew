require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  compatibility 'x86_64'
  @_ver = '88.0.4324.182'
  @_deb = "google-chrome-stable_#{@_ver}-1_amd64.deb"
  version @_ver

  if ARCH == 'x86_64' then
    depends_on 'nspr'
    depends_on 'cairo'
    depends_on 'gtk3'
    depends_on 'expat'
    depends_on 'cras'
    depends_on 'sommelier'
    source_url "https://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/#{@_deb}"
    source_sha256 'ab00e9412f5f20e30c7db5dc987473248f4adf9ebf2c3f928ef62e1ffb104fe6'
  end

  def self.install
    ENV['CREW_NOT_STRIP'] = '1'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    
    FileUtils.mv Dir.glob('usr/share/*'), './'
    FileUtils.mv Dir.glob('opt/google/chrome/*'), './'
    FileUtils.rm_rf ['usr', 'opt']
    
    FileUtils.ln_s "#{CREW_PREFIX}/share/chrome/google-chrome", '#{CREW_DEST_PREFIX}/bin/google-chrome-stable'
    FileUtils.ln_s "#{CREW_PREFIX}/share/chrome/google-chrome", '#{CREW_DEST_PREFIX}/bin/google-chrome'
    
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share"
  end
end
