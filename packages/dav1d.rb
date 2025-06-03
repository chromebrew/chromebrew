require 'buildsystems/meson'

class Dav1d < Meson
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.4.2'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ad333d174a10229b8d5eadf73c82acade4604fa190aa6a181badaefb3bd11e4',
     armv7l: '2ad333d174a10229b8d5eadf73c82acade4604fa190aa6a181badaefb3bd11e4',
     x86_64: '7004189fafe7b555354243db1b733ffa622d802b8f0d78764ec991a1e6f417a0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build

  meson_options CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16').to_s
end
