require 'buildsystems/autotools'

class Aide < Autotools
  description 'Advanced Intrusion Detection Environment'
  homepage 'https://aide.github.io'
  version '0.19'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/aide/aide.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2af194bf79b62e10b7099222bd11f0e3811983a8e9158b3c52210623657dfbf0',
     armv7l: '2af194bf79b62e10b7099222bd11f0e3811983a8e9158b3c52210623657dfbf0',
       i686: 'ae0bf14c5f1b3b8a7e81150bb3d6d1341475c40e755e1b4d03774415ccd48de2',
     x86_64: 'cf30bbf567dbfe35715dde38811c48bc186efa401629d42f78ea4d2c536c8820'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'check' => :build
  depends_on 'libgcrypt'
  depends_on 'mhash'
  depends_on 'nettle' # R
  depends_on 'pcre2'
  depends_on 'zlib'

  def self.postinstall
    ExitMessage.add <<~EOT.lightblue
      aide requires a configuration to operate.
      For information on the configuration format, run `man aide.conf`.
    EOT
  end

  run_tests
end
