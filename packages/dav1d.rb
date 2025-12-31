require 'buildsystems/meson'

class Dav1d < Meson
  description 'dav1d is a new AV1 cross-platform decoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.5.3'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '96852f722190552c9362c8cacc0450ed6e983d31f049f413191fabea83579b3e',
     armv7l: '96852f722190552c9362c8cacc0450ed6e983d31f049f413191fabea83579b3e',
       i686: 'bb2b93f8b16cb3c3e4f0f13152b55b9f0215be2ee3c58cf35f068dffb2cc8f54',
     x86_64: '422fe62bb8f9dd287e1b03a96f19d788ecd868b30e535b4d1f693aee0c1066f0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build
end
