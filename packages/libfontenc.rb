require 'package'

class Libfontenc < Package
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libfontenc-1.1.7.tar.xz'
  source_sha256 'c0d36991faee06551ddbaf5d99266e97becdc05edfae87a833c3ff7bf73cfec2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d2dee2568b7a2389cff4435c26653fe56c8b3bda1132ec74215ed87ca8eb287',
     armv7l: '8d2dee2568b7a2389cff4435c26653fe56c8b3bda1132ec74215ed87ca8eb287',
       i686: '20d2b4358c6b10ac9f215919ec0b57691565d7dd1e8883d32397ed5b1d773b32',
     x86_64: '4331cdbb4108722b6fc8d05249cdba21b67e917270ccba8b03b17808176dc30f'
  })

  depends_on 'xorg_proto'
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --with-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
