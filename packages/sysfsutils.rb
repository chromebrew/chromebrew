require 'buildsystems/autotools'

class Sysfsutils < Autotools
  description 'These are a set of utilities built upon sysfs, a new virtual filesystem in Linux kernel versions 2.5+ that exposes a system\'s device tree. The current version of sysfsutils includes libsysfs and systool.'
  homepage 'https://linux-diag.sourceforge.net/Sysfsutils.html'
  version '2.1.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/linux-ras/sysfsutils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08ea5ac3b4c6cfa2cefa71fc16fe7011f7bcfc223fdf0013f5fec8a558164739',
     armv7l: '08ea5ac3b4c6cfa2cefa71fc16fe7011f7bcfc223fdf0013f5fec8a558164739',
       i686: 'a9ab189f5843e8cca18017ec7e0fe48acdc68bf77ecc18bff7ed08ab88bf3b85',
     x86_64: '9ca3180951bfc976230861af19532ea87e7b62dcbcbc4c5061f5c07439b5cced'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
