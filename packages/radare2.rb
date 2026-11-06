require 'buildsystems/meson'

class Radare2 < Meson
  description 'unix-like reverse engineering framework and commandline tools'
  homepage 'https://www.radare.org/r/'
  version '6.2.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/radare/radare2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7a034077248ef9774988dbf4b10bd4af806ada8663f129375d3cf6f445172fc',
     armv7l: 'c7a034077248ef9774988dbf4b10bd4af806ada8663f129375d3cf6f445172fc',
       i686: 'd53780ecfcaca4a9c863d5b79b816f801f7dd9c0833d80f1eaa84a36b7b24319',
     x86_64: 'a69f25628887a4bd371ec381a90ab312495688578eddba63a518d446a757b936'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl'

  meson_options '-Duse_sys_openssl=true'
end
