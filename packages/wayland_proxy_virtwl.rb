require 'package'

class Wayland_proxy_virtwl < Package
  description 'Proxy Wayland connections across the VM boundary'
  homepage 'https://github.com/talex5/wayland-proxy-virtwl'
  @_ver = '5b576d5cad76de6ed7513cc85748efd78ca366cf'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url 'https://github.com/talex5/wayland-proxy-virtwl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf-1_armv7l/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf-1_armv7l/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf-1_x86_64/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2fb0aae6ab88066b9756405dde7af9664786ceffa4eb6e5e2a844dd8bbfb60c5',
     armv7l: '2fb0aae6ab88066b9756405dde7af9664786ceffa4eb6e5e2a844dd8bbfb60c5',
     x86_64: '9fa325befbcc08134de3be19d5362a4621c3b2288518fd5b49293c8fff0f17b6'
  })

  depends_on 'ocaml' => :build
  depends_on 'opam' => :build

  @OPAMROOT = "#{CREW_PREFIX}/share/opam"

  def self.build; end

  def self.install
    ENV['OPAMROOT'] = @OPAMROOT
    system "CHECK_IF_PREINSTALLED=false OPAMROOT=#{@OPAMROOT} opam install . --root=#{@OPAMROOT} --destdir=#{CREW_DEST_DIR}#{@OPAMROOT} -y"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../share/opam/bin/wayland-proxy-virtwl', 'wayland-proxy-virtwl'
    end
  end
end
