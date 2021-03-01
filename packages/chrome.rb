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
    x86_64: 'b7edb7cd5c166bf3c0a1d245baa5924e242c3b81b97090468bec778f41f40373'
  })
  
  is_external

  case ARCH
  when 'x86_64'
    depends_on 'alien' => :build
    depends_on 'nspr'
    depends_on 'cairo'
    depends_on 'gtk3'
    depends_on 'expat'
    depends_on 'cras'
    depends_on 'sommelier'
  end

  def self.install
    Dir.chdir('../') do
      ENV['CREW_NOT_STRIP'] = '1'
      FileUtils.ln_sf "#{CREW_PREFIX}/opt/google/chrome/google-chrome", 'bin/google-chrome'
      FileUtils.mv Dir.glob('*'), CREW_DEST_PREFIX
  end
end
