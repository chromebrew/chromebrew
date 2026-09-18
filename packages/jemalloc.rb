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
    aarch64: '8a965cca0115535fa9b1e48a4130fc3e60fef90aee9b626d636dee776c0a063b',
     armv7l: '8a965cca0115535fa9b1e48a4130fc3e60fef90aee9b626d636dee776c0a063b',
       i686: '4879d9e2f4a23811d125b24ec59f969ef31d4f553b463ec3d348c43096db232a',
     x86_64: '69b955e164e2a9e642f0381ea0cd422c62560c79007bfcbce9b8972bd2274970'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libxslt' => :build
end
