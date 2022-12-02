require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://xcb.freedesktop.org'
  @_ver = '1.15.2'
  version "#{@_ver}-py3.11"
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xcbproto.git'
  git_hashtag "xcb-proto-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.15.2-py3.11_armv7l/xcb_proto-1.15.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.15.2-py3.11_armv7l/xcb_proto-1.15.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.15.2-py3.11_i686/xcb_proto-1.15.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.15.2-py3.11_x86_64/xcb_proto-1.15.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4a3679e6631cb2381d6ecc563d83e4ae7fcf8df033d362525ed24f655639dc56',
     armv7l: '4a3679e6631cb2381d6ecc563d83e4ae7fcf8df033d362525ed24f655639dc56',
       i686: '7d66c57bde8969a08696d3ff2679cb32e4a96d9e9159bb93d4b2dbdc8e1370a1',
     x86_64: 'b928bb9db79c61bc301d46979ab688dde12e9fe56d031f7a5a94b8181bf61c6f'
  })

  depends_on 'python3'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
