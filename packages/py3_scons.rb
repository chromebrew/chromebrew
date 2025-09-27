require 'buildsystems/pip'

class Py3_scons < Pip
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '4.9.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9367afb7551a94f38bf1ec27316dfd438dbbe120c0e9b20b3b76eebe7e16005',
     armv7l: 'b9367afb7551a94f38bf1ec27316dfd438dbbe120c0e9b20b3b76eebe7e16005',
       i686: '5d1d64df852079813d714e070dad0935fed77fe5d97ad76599d03628866c85b0',
     x86_64: '399b23e77cc424b794f4f699ba1775764049bc1192f036e551ac062b7d50f351'
  })

  depends_on 'python3' # R
  no_source_build
end
