require 'buildsystems/autotools'

class Libemf < Autotools
  description 'libEMF is a C/C++ library which provides a drawing toolkit based on ECMA-234.'
  homepage 'https://libemf.sourceforge.net/'
  version '1.0.13'
  license 'LGPL-2.1 and GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/libemf/libemf/#{version}/libemf-#{version}.tar.gz"
  source_sha256 '74d92c017e8beb41730a8be07c2c6e4ff6547660c84bf91f832d8f325dd0cf82'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b78be20e47f02f5e9065699245f929ed2d014b8fd7e8d02352c535c72d3d536',
     armv7l: '5b78be20e47f02f5e9065699245f929ed2d014b8fd7e8d02352c535c72d3d536',
       i686: '4031abe4be0420f58ea128aa1a8c192d068b10de48cf1d42b97abb24f84c21e8',
     x86_64: 'b84ea6da767b7c6e2544b78bdf7ad262e8445fc865e7e3d83159053cec5dcac6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  run_tests
end
