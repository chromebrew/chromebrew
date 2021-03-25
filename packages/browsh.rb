require 'package'

class Browsh < Package
  description 'A fully-modern text-based browser, rendering to TTY and browsers.'
  homepage 'https://www.brow.sh'
  @_ver = '1.6.4'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'

  depends_on 'firefox'
    
  case ARCH
  when 'armv7l', 'aarch64'
    @_arch = 'armv7'
  when 'x86_64'
    @_arch = 'amd64'
  when 'i686'
    @_arch = '386'
  end
    
  @_file = "browsh_#{@_ver}_linux_#{@_arch}"
  @_url = "https://github.com/browsh-org/browsh/releases/download/v#{@_ver}/"

  source_url @_url + @_file
  
  def self.preflight
    source_sha256 `curl -Ls #{@_url}/browsh_#{@_ver}_checksums.txt`.scan(/(.*)#{@_file}$/)[0][0].strip
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install "../#{@_file}", "#{CREW_DEST_PREFIX}/bin/browsh", mode: 0755
  end
end