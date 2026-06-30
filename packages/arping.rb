require 'buildsystems/autotools'

class Arping < Autotools
  description 'ARP Ping'
  homepage 'https://www.habets.pp.se/synscan/programs_arping.html'
  version '2.29'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ThomasHabets/arping.git'
  git_hashtag "arping-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '415bc110d92dc212920ba08da1d522b5cd4e72d5a9474e84aaa76a993d687a16',
     armv7l: '415bc110d92dc212920ba08da1d522b5cd4e72d5a9474e84aaa76a993d687a16',
       i686: 'afdfe5a1f3c8ae03dce6d3a1cee67bec57908c0ff81c0d33dca074f5bb48e37f',
     x86_64: 'fba04d482ae05627c53b946029a3f606b9ae12f0f9a79fb0303e1c9a7be22f8a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libnet' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'libseccomp' => :executable

  autotools_configure_options "--prefix=#{CREW_PREFIX} --sbindir=#{CREW_PREFIX}/bin"
end
