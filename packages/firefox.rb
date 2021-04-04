require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  compatibility 'all'
  
  version '87.0' if ARCH =~ /^(i686|x86_64)/
  
  case ARCH
  when 'i686'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-i686/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '9127aee106dd9f09fac0c3cb89c5d75553384da4ec9be5943b60a5f55f31fccc'
  when 'x86_64'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '3c9207bee0a998634c4fd12293acfae207d16508749ad405bf1e8717d06acf02'
  when 'armv7l', 'aarch64'
    @_arm = true
    version '87.0-2' # follow debian patch
    source_url "https://http.us.debian.org/debian/pool/main/f/firefox/firefox_#{version}_armhf.deb"
    source_sha256 'bd4c13a8cf824c9c9c4f5dbb7ab3d0c1dda3bb5ddc99c53632509f835814e4c1'
  end

  depends_on 'gtk3'
  depends_on 'apulse'
  depends_on 'sommelier'

  def self.patch    
    @_wrapper = <<~EOF
      #!/bin/sh
      # To get sound working, used : https://codelab.wordpress.com/2017/12/11/firefox-drops-alsa-apulse-to-the-rescue/
      
      exec apulse #{CREW_LIB_PREFIX}/firefox/firefox "$@"
      EOF
  end

  def self.install
    if @_arm
      FileUtils.mv(Dir['./*'], CREW_DEST_PREFIX)
    else
      # follow official armhf deb, install to lib instead of share
      FileUtils.mkdir_p [CREW_DEST_LIB_PREFIX, "#{CREW_DEST_PREFIX}/bin/"]
      FileUtils.mv('.', "#{CREW_DEST_LIB_PREFIX}/firefox")
    end
    File.write("#{CREW_DEST_PREFIX}/bin/firefox", @_wrapper)
    File.chmod(0755, "#{CREW_DEST_PREFIX}/bin/firefox")
  end
end
