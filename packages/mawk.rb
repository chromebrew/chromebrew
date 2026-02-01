require 'buildsystems/autotools'

class Mawk < Autotools
  description 'mawk is a POSIX compatible interpreter of the awk language faster than gawk.'
  homepage 'https://invisible-island.net/mawk/'
  version '1.3.4-20260129'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://invisible-island.net/archives/mawk/mawk-#{version}.tgz"
  source_sha256 'a71fb7efea5a63770d8fb71321ef6ae7afe0592f1aa7f7e2b496c26ccbb392a4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6dd0ef59ad00d6b52972e0b3751d40d83adcecbe05cfd8cc0542573a54c6700f',
     armv7l: '6dd0ef59ad00d6b52972e0b3751d40d83adcecbe05cfd8cc0542573a54c6700f',
       i686: '87e1372ac7001d53eeb3d000563b30cece7691ae171871600f33ad5b5fa94fde',
     x86_64: '049626aa62ae80228e7315bb775d08325a12d5618e4eb06596ed22e85a6b04fa'
  })

  depends_on 'glibc' # R

  autotools_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/mawk", "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
