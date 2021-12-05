require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://xcb.freedesktop.org'
  version '1.14.1-1'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://x.org/releases/individual/proto/xcb-proto-1.14.1.tar.xz'
  source_sha256 'f04add9a972ac334ea11d9d7eb4fc7f8883835da3e4859c9afa971efdf57fcc3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.14.1-1_armv7l/xcb_proto-1.14.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.14.1-1_armv7l/xcb_proto-1.14.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.14.1-1_i686/xcb_proto-1.14.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.14.1-1_x86_64/xcb_proto-1.14.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '51a4e97cece7e7e607c4b23ef77664d0b2d5ad1e31709fbf93f9a4f484edddc5',
     armv7l: '51a4e97cece7e7e607c4b23ef77664d0b2d5ad1e31709fbf93f9a4f484edddc5',
       i686: '388aa153c502b457d10799ad29f458b5b3b126347b960bc8301189843efc7883',
     x86_64: 'd83ce95516759805672daf6410796e2fd09973f93d1d813fee13e7cfc66f3690'
  })

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./autogen.sh #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
