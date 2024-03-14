require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.4.0'
  license 'BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29d4434e8d6185fa8b4e4ec6b458ba830582210dca6022486f29649bdfee21a9',
     armv7l: '29d4434e8d6185fa8b4e4ec6b458ba830582210dca6022486f29649bdfee21a9',
     x86_64: 'ec08ca4e413d63815a2ccbebf77590241116897135b62c0963cb7f98ab3e9ffa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
