require 'package'

class Xcb_util_cursor < Package
  description 'The xcb-util-cursor package provides a module that implements the XCB cursor library. It is a the XCB replacement for libXcursor.'
  homepage 'http://xcb.freedesktop.org'
  version '0.1.4'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.4.tar.xz'
  source_sha256 '28dcfe90bcab7b3561abe0dd58eb6832aa9cc77cfe42fcdfa4ebe20d605231fb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6024a6c057f93b6f2fb41607cd4b94ce5d790dc0dec95c16279c0461f6d9c8b0',
     armv7l: '6024a6c057f93b6f2fb41607cd4b94ce5d790dc0dec95c16279c0461f6d9c8b0',
       i686: '2e8232bf927297a009da0171ed1a456294c74f1104f99b8fe71aae2bcb904529',
     x86_64: '0b93d9946e1c41c3fc77c638a76d17d314593ccaa938b0898f57c02076b8c6c5'
  })

  depends_on 'xcb_util'
  depends_on 'm4'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_image'
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
