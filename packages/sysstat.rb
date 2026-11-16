require 'buildsystems/autotools'

class Sysstat < Autotools
  description 'The sysstat utilities are a collection of performance monitoring tools for Linux. These include sar, sadf, mpstat, iostat, tapestat, pidstat, cifsiostat and sa tools.'
  homepage 'https://sysstat.github.io/'
  version '12.8.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/sysstat/sysstat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a0472e07e30b4e95b875926074af40dc8d76efb2e267adc760b8963497a90f6',
     armv7l: '5a0472e07e30b4e95b875926074af40dc8d76efb2e267adc760b8963497a90f6',
       i686: '82e57d6cb55b3b7ff1ca27292a95f2ad2a05a5b882ebd67a7261fdda170e20b5',
     x86_64: '5bfb61a8a68d77c3eb1480bad406aa37b1b8d2d5863160785a3b5a8167cccd0d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_pre_configure_options "man_group=#{`whoami`.chomp}"
  autotools_configure_options '--disable-automated-sar-reporting'
end
