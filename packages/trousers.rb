require 'package'

class Trousers < Package
  description 'The open-source TCG Software Stack.'
  homepage 'http://trousers.sourceforge.net/'
  @_ver = '0.3.15'
  version "#{@_ver}-1"
  license 'CPL-1.0 and GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/trousers/trousers/#{@_ver}/trousers-#{@_ver}.tar.gz"
  source_sha256 '1e5be93e518372acf1d92d2f567d01a46fdb0b730487e544e6fb896c59cac77f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/trousers/0.3.15-1_armv7l/trousers-0.3.15-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/trousers/0.3.15-1_armv7l/trousers-0.3.15-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/trousers/0.3.15-1_i686/trousers-0.3.15-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/trousers/0.3.15-1_x86_64/trousers-0.3.15-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3f164e9a58f163ccb8105c8932a0aef22b15d1e425307948e80ea052c2b60989',
     armv7l: '3f164e9a58f163ccb8105c8932a0aef22b15d1e425307948e80ea052c2b60989',
       i686: '2f62ba92301c5fc9753b5d159b783bd00d109bac32e0b198309acee2ec01a2b2',
     x86_64: 'ae6c76c54c1337dc41efc95b6017e45999a56a3470620420d95f76e7e671a0d2'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R

  def self.build
    system './bootstrap.sh'
    system "./configure \
      #{CREW_OPTIONS} \
      --with-gui=none"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
