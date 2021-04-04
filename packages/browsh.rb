require 'package'

class Browsh < Package
  description 'A fully-modern text-based browser with Firefox backend, rendering to TTY and browsers.'
  homepage 'https://www.brow.sh'
  @_ver = '1.6.4'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'

  depends_on 'firefox'
    
  case ARCH
  when 'armv7l', 'aarch64'
    @_arch = 'armv7'
    source_sha256 '36f02b21cbac554e1ca05e382560bf10043b402d2c345cbfffa9f1f20992bec2'
  when 'x86_64'
    @_arch = 'amd64'
    source_sha256 'd0bbdfe07e1494bb097dcff6290f17f98f6e3e5546f17139223b75d97c1caab5'
  when 'i686'
    @_arch = '386'
    source_sha256 '43969b4af481c387303ce44357d4f912f250bb00a13c094968809e36fd7988e5'
  end
    
  @_file = "browsh_#{@_ver}_linux_#{@_arch}"
  @_url = "https://github.com/browsh-org/browsh/releases/download/v#{@_ver}/"

  source_url @_url + @_file

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install "../#{@_file}", "#{CREW_DEST_PREFIX}/bin/browsh", mode: 0755
  end
end
