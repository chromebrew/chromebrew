require 'buildsystems/autotools'

class Sleuthkit < Autotools
  description 'The Sleuth Kit® (TSK) is a library and collection of command line tools that allow you to investigate disk images.'
  homepage 'https://www.sleuthkit.org/sleuthkit/'
  version '4.15.0'
  license 'BSD, CPL-1.0, GPL-2+, IBM and Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/sleuthkit/sleuthkit.git'
  git_hashtag "sleuthkit-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6ec4ed0a74c16af52580474c07b23a1298bb7b231899a96b02951a95fa343da',
     armv7l: 'f6ec4ed0a74c16af52580474c07b23a1298bb7b231899a96b02951a95fa343da',
       i686: '5805cd0aa0a2ad9c736b3477981d675320b9de68d628a99432700bacb8063b32',
     x86_64: '3bacdd0de80cb020511932587b46a2def582f273739825edc815bddb048d9f39'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'sqlite' => :library
  depends_on 'zlib' => :library
end
