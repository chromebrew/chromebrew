require 'buildsystems/autotools'

class Sysstat < Autotools
  description 'The sysstat utilities are a collection of performance monitoring tools for Linux. These include sar, sadf, mpstat, iostat, tapestat, pidstat, cifsiostat and sa tools.'
  homepage 'https://sysstat.github.io/'
  version '12.8.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/sysstat/sysstat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fba6cb3a5d87032eeef03825ce89e4ec870cd5e88eb638b495004a7e79ffe282',
     armv7l: 'fba6cb3a5d87032eeef03825ce89e4ec870cd5e88eb638b495004a7e79ffe282',
       i686: '1c6b70023336e57001b3cfc35ac70e5b898f6528ccebb67adc230693041814aa',
     x86_64: 'deec9065516e164d598cac67ef893d728528c8dd6e46a88bedcb096c47ca03b2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_pre_configure_options "man_group=#{`whoami`.chomp}"
  autotools_configure_options '--disable-automated-sar-reporting'
end
