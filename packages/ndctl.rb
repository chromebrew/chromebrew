require 'buildsystems/meson'

class Ndctl < Meson
  description 'Helper tools and libraries for managing the libnvdimm (non-volatile memory device) sub-system in the Linux kernel'
  homepage 'https://github.com/pmem/ndctl'
  version '85'
  license 'GPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/pmem/ndctl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2caf564f7b99b83b1fe9590a0da622a41d23795bd444dafdf927f11827d5760',
     armv7l: 'e2caf564f7b99b83b1fe9590a0da622a41d23795bd444dafdf927f11827d5760',
     x86_64: '844e9bb578e27a76d2a5081afa3eb4f2ce411a2b3653d95245a2ef15f9167c8f'
  })

  depends_on 'bash_completion' => :build
  depends_on 'eudev' => :build
  depends_on 'iniparser' => :build
  depends_on 'json_c' => :build
  depends_on 'keyutils' => :build
  depends_on 'libkmod' => :build
  depends_on 'libtraceevent' => :build
  depends_on 'libtracefs' => :build
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'xmlto' => :build

  print_source_bashrc

  meson_options '-Dsystemd=disabled'

  meson_build_extras do
    File.write '10-ndctl', <<~EOF
      #!/bin/bash
      source #{CREW_PREFIX}/share/bash-completion/completions/ndctl
    EOF
  end

  meson_install_extras do
    FileUtils.install '10-ndctl', "#{CREW_DEST_PREFIX}/etc/env.d/10-ndctl", mode: 0o644
  end
end
