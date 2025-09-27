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
       i686: '282fba9583ce3404692223a84e7fcf0531fb16acdff68bb5307da31cd2ad4934',
     x86_64: '399b23e77cc424b794f4f699ba1775764049bc1192f036e551ac062b7d50f351'
  })

  depends_on 'python3' # R
  no_source_build
end
