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
    aarch64: 'dbc7832b84f64fe292f77cc74e9ee809acb69098072f10d7cab4bf61c3a47070',
     armv7l: 'dbc7832b84f64fe292f77cc74e9ee809acb69098072f10d7cab4bf61c3a47070',
    x86_64: '9d5e0b7ca63b3ec2949f66da4e594741c729a7aa9e488ba16f4a7e6e237d4671'
  })

  depends_on 'ocaml' => :build
  depends_on 'opam' => :build

  @OPAMROOT = "#{CREW_PREFIX}/share/opam"

  def self.build; end

  def self.install
    ENV['OPAMROOT'] = @OPAMROOT
    system "LINKFLAGS='-fuse-ld=bfd' LDFLAGS='-fuse-ld=bfd' OPAMROOT=#{@OPAMROOT} opam install . --root=#{@OPAMROOT} --destdir=#{CREW_DEST_DIR}#{@OPAMROOT} -y"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../share/opam/bin/wayland-proxy-virtwl', 'wayland-proxy-virtwl'
    end
  end
end
