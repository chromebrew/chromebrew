require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.4.1'
  license 'BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '04095a79a6f15e15760b6d355a8f8a3b3e6ff1a402b688f96990d9463ddc4f0e',
     armv7l: '04095a79a6f15e15760b6d355a8f8a3b3e6ff1a402b688f96990d9463ddc4f0e',
     x86_64: 'b298fcec9adb0a2afe25418225e3cb88e8839d042185c43a5966e35ae98cef28'
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
