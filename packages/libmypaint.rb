require 'package'

class Libmypaint < Package
  description 'Libmypaint is MyPaint\'s brushstroke rendering code, in a form that can be used by other programs.'
  homepage 'http://mypaint.org/'
  @_ver = '1.6.1'
  version "#{@_ver}-1"
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/mypaint/libmypaint.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ba8808e23307488b85fb7153402bc14fc5f9669ca38defc67b68c008a522cab',
     armv7l: '4ba8808e23307488b85fb7153402bc14fc5f9669ca38defc67b68c008a522cab',
       i686: '50193172a43025aa027cfdbe08582f2835f8b499be088e5c81955ea36333b8b0',
     x86_64: '6c694a3414e517d05de4ca5c5e4151383dd2895874b2d1dd809560e7af31e362'
  })

  depends_on 'gegl'
  depends_on 'jsonc'
  depends_on 'openmp'
  depends_on 'babl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'json_glib' # R

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "./configure \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-openmp \
      --enable-gegl"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
