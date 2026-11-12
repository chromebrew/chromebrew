require 'buildsystems/meson'

class Sshfs < Meson
  description 'A network filesystem client to connect to SSH servers.'
  homepage 'https://github.com/libfuse/sshfs'
  version '3.7.7'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libfuse/sshfs.git'
  git_hashtag "sshfs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d9fabf6f2ff110490379099594a507b62a7560190e067a705244bdcafe6170f',
     armv7l: '9d9fabf6f2ff110490379099594a507b62a7560190e067a705244bdcafe6170f',
     x86_64: '8e0efd737c72565381e16cd1d7dff2fc2f1352669d7072938685baa09497f927'
  })

  depends_on 'fuse3' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'py3_docutils' => :build
end
