require 'buildsystems/autotools'

class Jemalloc < Autotools
  description 'jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support.'
  homepage 'http://jemalloc.net/'
  version '5.4.0'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/jemalloc/jemalloc/releases/download/#{version}/jemalloc-#{version}.tar.bz2"
  source_sha256 '200776fac271093e7c2f21edd6d62657ecd2be578d9328633f2a86bfa6ef4f1d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '92dbc8c2871919aa16f7baba2c39417e9424e7ec4e83487e80ead28626feda5d',
     armv7l: '92dbc8c2871919aa16f7baba2c39417e9424e7ec4e83487e80ead28626feda5d',
       i686: '2b9c95d8873fe5e1861af5da1ac12f34a669b4ae298021fc429cfd42a13c6908',
     x86_64: '04071152be5af61c3688f0df4f5662b4c3f37a2d02ca18ef0142a2579296f05f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libxslt' => :build
end
