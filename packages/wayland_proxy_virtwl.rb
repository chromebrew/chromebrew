require 'package'

class Wayland_proxy_virtwl < Package
  description 'Proxy Wayland connections across the VM boundary'
  homepage 'https://github.com/talex5/wayland-proxy-virtwl'
  @_ver = 'd7f58d405514dd031f2f12e402c8c6a58e62a885'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/talex5/wayland-proxy-virtwl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/d8596b8ef7b8b7b27e48f3621018e5edd2b3a6f2_armv7l/wayland_proxy_virtwl-d8596b8ef7b8b7b27e48f3621018e5edd2b3a6f2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/d8596b8ef7b8b7b27e48f3621018e5edd2b3a6f2_armv7l/wayland_proxy_virtwl-d8596b8ef7b8b7b27e48f3621018e5edd2b3a6f2-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/d8596b8ef7b8b7b27e48f3621018e5edd2b3a6f2_i686/wayland_proxy_virtwl-d8596b8ef7b8b7b27e48f3621018e5edd2b3a6f2-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/d8596b8ef7b8b7b27e48f3621018e5edd2b3a6f2_x86_64/wayland_proxy_virtwl-d8596b8ef7b8b7b27e48f3621018e5edd2b3a6f2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5e22eb523da33a806e6f365a903b019fe1c7721a835a9e9b50d6ac1856c3c166',
     armv7l: '5e22eb523da33a806e6f365a903b019fe1c7721a835a9e9b50d6ac1856c3c166',
    i686: '50d9cd08dd362fb47bbbc501315393fd275393fc63cff555f0aa3ed63b6de3a0',
  x86_64: '90b400156918b68b5617a7441e2ffc65b21fabd7d588e7e12b1157212a7943d3'
  })

  depends_on 'ocaml' => :build
  depends_on 'opam' => :build
  depends_on 'xwayland'

  @OPAMROOT = "#{CREW_PREFIX}/share/opam"

  def self.install
    ENV['OPAMROOT'] = @OPAMROOT
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    if (ARCH == 'armv7l') || (ARCH == 'aarch64')
      # ld.gold breaks logs 0.7.0 builds with ocaml 4.1.2
      FileUtils.cp "#{CREW_PREFIX}/bin/ld.bfd", "#{CREW_DEST_PREFIX}/bin/ld"
    end
    system "PATH=#{CREW_DEST_PREFIX}/bin:$PATH OPAMROOT=#{@OPAMROOT} opam install . --root=#{@OPAMROOT} --destdir=#{CREW_DEST_DIR}#{@OPAMROOT} -y"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/ld" if File.exist?("#{CREW_DEST_PREFIX}/bin/ld")
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../share/opam/bin/wayland-proxy-virtwl', 'wayland-proxy-virtwl'
    end
  end

  def self.postinstall
    puts <<~'EOFSTRING'.lightblue
      Note that there is not yet hardware acceleration in wayland-proxy-virtwl.
      wayland-proxy-virtwl example usage (before running a gui program):
    EOFSTRING
    puts <<~'EOFSHELLCODE'.lightcyan
      wayland-proxy-virtwl --wayland-display wayland-2 --x-display=2 --xrdb Xft.dpi:150 &
      export WAYLAND_DISPLAY=wayland-2
      export DISPLAY=:2
    EOFSHELLCODE
  end
end
