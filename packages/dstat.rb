require 'package'

class Dstat < Package
  description 'Dstat is a versatile replacement for vmstat, iostat, netstat and ifstat.'
  homepage 'http://dag.wiee.rs/home-made/dstat/'
  version '0.7.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/dagwieers/dstat/archive/0.7.3.tar.gz'
  source_sha256 '46e63821857b69fbc60cb2c7d893ccdd6f31cd9ef24b8bb0b68951e1c7374898'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '7a9d0511b6c3248d64fd453ccac3c360560bc6d2231e9db2d8b45347001052a7',
     armv7l: '7a9d0511b6c3248d64fd453ccac3c360560bc6d2231e9db2d8b45347001052a7',
       i686: '198ec4a016d2141e8252b5e620ece1fc3d14e538e6ce357434a2f8c041a9acce',
     x86_64: 'd37062db82e51d3bdfa30974b330442d8297f4e41d9a8705e4e51c41bfb604ba'
  })

  depends_on 'python27'

  def self.build; end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
