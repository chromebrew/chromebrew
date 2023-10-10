require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.3.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.3.0_armv7l/dav1d-1.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.3.0_armv7l/dav1d-1.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.3.0_i686/dav1d-1.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.3.0_x86_64/dav1d-1.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7656d57ea668cfc33a424aa369f4761f6c11c85fefc19451c92e250f14e365e8',
     armv7l: '7656d57ea668cfc33a424aa369f4761f6c11c85fefc19451c92e250f14e365e8',
       i686: '97cd95dd217fa9a6c259835cb8afa74e66b38426ad005e2e760532750ce01865',
     x86_64: '87a070dc273dbb63346e7199b4ca95edfeb79d4a0bbf0ee764562c5f9de1170a'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
