require 'buildsystems/autotools'

class Arping < Autotools
  description 'ARP Ping'
  homepage 'https://www.habets.pp.se/synscan/programs_arping.html'
  version '2.28'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ThomasHabets/arping.git'
  git_hashtag "arping-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '093718d8c147470ee1c3935d23e80f237ab2047e88b269daa0797b5192319078',
     armv7l: '093718d8c147470ee1c3935d23e80f237ab2047e88b269daa0797b5192319078',
       i686: '1776a40819efb729991aa1f404b6bbe56d18e003cd7d7da8cb1334f6b4b46437',
     x86_64: 'ce751dae17387cc0e42704b2596e9d0aa13b848e3a63db416745dfdfce27b188'
  })

  depends_on 'glibc' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libnet' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'libseccomp' => :executable

  autotools_configure_options "--prefix=#{CREW_PREFIX} --sbindir=#{CREW_PREFIX}/bin"
end
