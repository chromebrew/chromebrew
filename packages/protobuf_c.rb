# Adapted from Arch Linux protobuf-c PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf-c/trunk/PKGBUILD
# Before upgrading protobuf_c, make sure to upgrade protobuf first.

require 'buildsystems/autotools'

class Protobuf_c < Autotools
  description 'Protocol Buffers implementation in C'
  homepage 'https://github.com/protobuf-c/protobuf-c'
  version '1.5.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protobuf-c/protobuf-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd769f5261492bde10ed8cda59432ebebf9d06b17ea25d78c986402e633e22300',
     armv7l: 'd769f5261492bde10ed8cda59432ebebf9d06b17ea25d78c986402e633e22300',
       i686: '7fb8eac7dd6a5af65b3ea10d061d8404d9baedcc829994e396a3d71dbd504535',
     x86_64: '2b605a6ad5f1bc6ab6988b04621078d2357edc0febf0474d6c6b4a101202a6de'
  })

  depends_on 'abseil_cpp' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'protobuf' => :executable

  def self.patch
    patch = [
      [
        # Fix error: ‘const class google::protobuf::FieldDescriptor’ has no member named ‘label’; did you mean ‘Label’?
        'https://patch-diff.githubusercontent.com/raw/protobuf-c/protobuf-c/pull/797.diff',
        'bbb5543aafba2611c5b450f2403804a0e8fad0e082e22c1f838b5190ce298089'
      ]
    ]
    ConvenienceFunctions.patch(patch)
  end
end
