require 'buildsystems/autotools'

class Aide < Autotools
  description 'Advanced Intrusion Detection Environment'
  homepage 'https://aide.github.io'
  version '0.18.8-f445264'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/aide/aide.git'
  git_hashtag 'f445264ff5cd61a932185182d035588c89af5f51'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec5d0b22edc4df5485eada1d00bcc4a7cd88677a4a2a5488216dbf5715294b19',
     armv7l: 'ec5d0b22edc4df5485eada1d00bcc4a7cd88677a4a2a5488216dbf5715294b19',
       i686: '17518a9cc263eb975cbaccb5a41fa54cc8377ea0a7da66e8af4eed9e8a2f8ed4',
     x86_64: '7f585aeab90b488774a8b079b5e2095c0141fadd828fb0d6e4684e4c40ab1a4e'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'check' => :build
  depends_on 'libgcrypt'
  depends_on 'mhash'
  depends_on 'pcre2'
  depends_on 'zlibpkg'

  def self.patch
    # Set autogen.sh and version.sh as executable
    downloader 'https://patch-diff.githubusercontent.com/raw/aide/aide/pull/174.patch', '4caa00105c558d189c1d677677add208b3f0134a77044ad95107d16fd5010a2a'
    system 'git apply 174.patch'
  end

  run_tests
end
