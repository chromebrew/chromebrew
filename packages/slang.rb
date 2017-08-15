require 'package'

class Slang < Package
  description 'S-Lang is a multi-platform programmer\'s library designed to allow a developer to create robust multi-platform software.'
  homepage 'http://www.jedsoft.org/slang/'
  version '2.3.1a'
  source_url 'http://www.jedsoft.org/releases/slang/slang-2.3.1a.tar.bz2'
  source_sha256 '54f0c3007fde918039c058965dffdfd6c5aec0bad0f4227192cc486021f08c36'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/slang-2.3.1a-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/slang-2.3.1a-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/slang-2.3.1a-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/slang-2.3.1a-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1cee3907eef94f5e66b3281fb98379cb28676dc5c4793cf74daddf10a06a4e2e',
     armv7l: '1cee3907eef94f5e66b3281fb98379cb28676dc5c4793cf74daddf10a06a4e2e',
       i686: 'd82831ed4874164413d878edcbe11603681dd2bd56ada9e005ae20917f4bbaf6',
     x86_64: '0212b1d29926d39861ceee0003041a0b9fff11f2128558aafcffed894f6caff7',
  })

  def self.build
    system "./configure", "--prefix=/usr/local", "--without-x"

    # force to compile in sequential since slang Makefile doesn't work in parallel
    system "make", "-j1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
