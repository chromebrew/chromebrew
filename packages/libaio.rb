require 'package'

class Libaio < Package
  description 'Linux-native asynchronous I/O access library'
  homepage 'https://pagure.io/libaio'
  version '0.3.113-932de6c'
  license 'LGPL-2'
  # Use release patched to fix lto issues as per
  # https://marc.info/?l=linux-aio&m=164999309120529&w=2
  compatibility 'all'
  source_url 'https://git.hadrons.org/cgit/sys/libaio.git'
  git_hashtag '932de6c91978639eee576ecdc1343b52e5a0a54a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaio/0.3.113-932de6c_armv7l/libaio-0.3.113-932de6c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaio/0.3.113-932de6c_armv7l/libaio-0.3.113-932de6c-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaio/0.3.113-932de6c_i686/libaio-0.3.113-932de6c-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaio/0.3.113-932de6c_x86_64/libaio-0.3.113-932de6c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a950ffa572b765898a2607ac7a220a854f2f48578128e67a1c122687d817dc5e',
     armv7l: 'a950ffa572b765898a2607ac7a220a854f2f48578128e67a1c122687d817dc5e',
       i686: '0a22ed56376f7c0d7b0518f4f2503efc1701583eb5c60cd02fcfc1111a97a04b',
     x86_64: '4021e49d7549ef0601f2baf53a2b12f62d39c7535bc4db13a4153968f00789e8'
  })

  depends_on 'glibc' # R

  def self.build
    system "sed -i 's,prefix=/usr,prefix=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,libdir=$(prefix)/lib,libdir=#{CREW_LIB_PREFIX},' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
