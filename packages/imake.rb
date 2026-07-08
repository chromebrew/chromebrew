require 'buildsystems/autotools'

class Imake < Autotools
  description 'A build automation system written for the X Window System.'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.0.11'
  license 'custom'
  compatibility 'all'
  source_url "https://www.x.org/releases/individual/util/imake-#{version}.tar.xz"
  source_sha256 '55955527eaebe94633e4083d4fe5f2160a65fe4c6dafdee48b89fea5f1ca8a78'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97bc1972c81637af20e1e0fbbadc914618cca7d7035dc15031a90a938e15d6d3',
     armv7l: '97bc1972c81637af20e1e0fbbadc914618cca7d7035dc15031a90a938e15d6d3',
       i686: 'fe954beae7f3f6f82f6d62236eefe891610bc34c430f6efffd6e0ef7509f3890',
     x86_64: '3874d07eaefc983608a2591042167235703aa5503c6b5b5f6345e2e02852aaf2'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'xorg_cf_files' => :executable
  depends_on 'xorg_proto' => :executable

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc"

  def self.patch
    # Fix bash: mkhtmlindex: /usr/bin/perl: bad interpreter: No such file or directory
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' mkhtmlindex.pl"
  end
end
