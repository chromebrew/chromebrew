# Adapted from Arch Linux opam PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/opam/trunk/PKGBUILD

require 'package'

class Wayland_proxy_virtwl < Package
  description 'Proxy Wayland connections across the VM boundary'
  homepage 'https://github.com/talex5/wayland-proxy-virtwl'
  @_ver = '5b576d5cad76de6ed7513cc85748efd78ca366cf'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/talex5/wayland-proxy-virtwl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf_armv7l/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf_armv7l/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf_i686/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf_x86_64/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9cd15da6fb9278ec06a85e8db9192691cb9785e07806a3e02aa1d2e64056aef2',
     armv7l: '9cd15da6fb9278ec06a85e8db9192691cb9785e07806a3e02aa1d2e64056aef2',
       i686: 'eeaae9cf7237f0941ea8810089d71f75c0fa79388f45762be33d1bcde60c7ab8',
     x86_64: 'dc6ec360d6f58b84f41cb2b97ba0c7355307d3f1b1d249e82cc0467b70cd54bf'
  })

  depends_on 'ocaml' => :build
  depends_on 'opam' => :build

  def self.build; end

  def self.install
    ENV['OPAMROOT'] = "#{CREW_PREFIX}/opam"
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system "OPAMROOT=#{CREW_PREFIX}/opam opam install . --root=#{CREW_PREFIX}/opam --destdir=#{CREW_DEST_PREFIX}/opam -y"
  end
end
