# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'package'

class Tevent < Package
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  @_ver = '0.16.1'
  version "#{@_ver}-py3.12"
  license 'LGPL'
  compatibility 'all'
  source_url "https://samba.org/ftp/tevent/tevent-#{@_ver}.tar.gz"
  source_sha256 '362971e0f32dc1905f6fe4736319c4b8348c22dc85aa6c3f690a28efe548029e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23b98b9a9fe0742e40eac23182e333d2cc20490206a320dd3b7b3a4688f1de5d',
     armv7l: '23b98b9a9fe0742e40eac23182e333d2cc20490206a320dd3b7b3a4688f1de5d',
       i686: '4008ab286b57333173b5f440eeedeb2da44fa3e2fa850e5a1e7a63b309e90ac8',
     x86_64: '9e4cfdcc1769a929148ec5a6c02100b8a5ca9ad645327c999283ae130f690449'
  })

  depends_on 'cmocka' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  depends_on 'python3' => :build
  depends_on 'talloc' # R

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
