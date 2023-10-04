require 'buildsystems/autotools'

class Xcb_proto < Autotools
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://xcb.freedesktop.org'
  @_ver = '1.16.0'
  version "#{@_ver}-py3.12"
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xcbproto.git'
  git_hashtag "xcb-proto-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.16.0-py3.12_armv7l/xcb_proto-1.16.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.16.0-py3.12_armv7l/xcb_proto-1.16.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.16.0-py3.12_i686/xcb_proto-1.16.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.16.0-py3.12_x86_64/xcb_proto-1.16.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4c08e16bb63c40aa0fcf49e6edcdf7db32796c47a46ad6d83b31d1ed6b2c71b7',
     armv7l: '4c08e16bb63c40aa0fcf49e6edcdf7db32796c47a46ad6d83b31d1ed6b2c71b7',
       i686: 'ddf20e1678585c76703f308086191771be4953d75ba498bd7e508cb149cd697c',
     x86_64: 'd950c6338bb627e52710fc51f9d3e2b0f330c60f97e1036ff3677f993444a229'
  })

  depends_on 'python3'
end
