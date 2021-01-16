require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  compatibility 'all'
  @_ver = '87.0.4280.141'
  version @_ver

  case ARCH
  when 'x86_64'
    source_url "https://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/google-chrome-stable_#{@_ver}-1_amd64.deb"
    source_sha256 'b7edb7cd5c166bf3c0a1d245baa5924e242c3b81b97090468bec778f41f40373'
    depends_on 'alien' => :build
    depends_on 'nspr'
    depends_on 'cairo'
    depends_on 'gtk3'
    depends_on 'expat'
    depends_on 'cras'
    depends_on 'sommelier'
  end

  def self.build
    @_deb = "google-chrome-stable_#{@_ver}-1_amd64.deb"
    FileUtils.mv "../#{@_deb}", '.'
    system "alien -tc #{@_deb}"
    system "tar xvf google-chrome-stable-#{@_ver}.tgz > /dev/null"
  end

  def self.install
    ENV['CREW_NOT_STRIP'] = '1'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'opt/', CREW_DEST_PREFIX
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'etc', CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/opt/google/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end
end