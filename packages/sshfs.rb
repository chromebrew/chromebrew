require 'buildsystems/meson'

class Sshfs < Meson
  description 'A network filesystem client to connect to SSH servers.'
  homepage 'https://github.com/libfuse/sshfs'
  version '3.7.6'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libfuse/sshfs.git'
  git_hashtag "sshfs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5884ea8a54bc4b3db7b99f5627fd3db39fb5c78ce41ee0de82bdfa8cb37ab0c4',
     armv7l: '5884ea8a54bc4b3db7b99f5627fd3db39fb5c78ce41ee0de82bdfa8cb37ab0c4',
     x86_64: '13d622655e68aa691d4a1a32e8cf7bc7bf8d3d6e6ad4837b102ba024d8c416d9'
  })

  depends_on 'fuse3' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'py3_docutils' => :build
end
