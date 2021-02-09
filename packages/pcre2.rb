require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  @_ver = '10.36'
  version @_ver
  compatibility 'all'
  source_url "https://ftp.pcre.org/pub/pcre/pcre2-#{@_ver}.tar.gz"
  source_sha256 'b95ddb9414f91a967a887d69617059fb672b914f56fa3d613812c1ee8e8a1a37'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.36-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.36-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.36-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.36-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f83694fcc265d5dc06c627e47ea7765e74eb337727277f4dbbd8df7d1d5e8114',
     armv7l: 'f83694fcc265d5dc06c627e47ea7765e74eb337727277f4dbbd8df7d1d5e8114',
       i686: '845f8a7fa844ea982be1b6a81e5f48d23be348861f6d33fd84ca5b98dd032b54',
     x86_64: '17002f3ed5ebba3944dc1050a314e75b03a25a0bfc54ac1c12d1060178456199'
  })

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      --with-pic \
      --enable-unicode-properties \
      --enable-pcre2-16 \
      --enable-pcre2-32 \
      --enable-jit \
      --enable-pcre2test-libreadline"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
