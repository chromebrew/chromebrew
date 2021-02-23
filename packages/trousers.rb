require 'package'

class Trousers < Package
  description 'The open-source TCG Software Stack.'
  homepage 'http://trousers.sourceforge.net/'
  @_ver = '0.3.15'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/trousers/trousers/#{@_ver}/trousers-#{@_ver}.tar.gz"
  source_sha256 '1e5be93e518372acf1d92d2f567d01a46fdb0b730487e544e6fb896c59cac77f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.15-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.15-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.15-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.15-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3f164e9a58f163ccb8105c8932a0aef22b15d1e425307948e80ea052c2b60989',
     armv7l: '3f164e9a58f163ccb8105c8932a0aef22b15d1e425307948e80ea052c2b60989',
       i686: '2f62ba92301c5fc9753b5d159b783bd00d109bac32e0b198309acee2ec01a2b2',
     x86_64: 'ae6c76c54c1337dc41efc95b6017e45999a56a3470620420d95f76e7e671a0d2'
  })

  def self.build
    system './bootstrap.sh'
    system "CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      ./configure \
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
