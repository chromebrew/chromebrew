require 'package'

class Wayland_proxy_virtwl < Package
  description 'Proxy Wayland connections across the VM boundary'
  homepage 'https://github.com/talex5/wayland-proxy-virtwl'
  version 'd7f58d405514dd031f2f12e402c8c6a58e62a885'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/talex5/wayland-proxy-virtwl.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/d7f58d405514dd031f2f12e402c8c6a58e62a885_armv7l/wayland_proxy_virtwl-d7f58d405514dd031f2f12e402c8c6a58e62a885-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/d7f58d405514dd031f2f12e402c8c6a58e62a885_armv7l/wayland_proxy_virtwl-d7f58d405514dd031f2f12e402c8c6a58e62a885-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/d7f58d405514dd031f2f12e402c8c6a58e62a885_i686/wayland_proxy_virtwl-d7f58d405514dd031f2f12e402c8c6a58e62a885-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/d7f58d405514dd031f2f12e402c8c6a58e62a885_x86_64/wayland_proxy_virtwl-d7f58d405514dd031f2f12e402c8c6a58e62a885-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '057575d06814635e9cdf22463641569486d7e2b663c82db3c31939fef0a346e7',
     armv7l: '057575d06814635e9cdf22463641569486d7e2b663c82db3c31939fef0a346e7',
       i686: '9258061ba55c3ce7b1a65a07a0d98ec68007118533339fd577e71f6154a8d291',
     x86_64: '8a4ccc9cca2248d2f729e6ab0d66e97e6f3799a14a5da38d955ff8fb1a41f08d'
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
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/ld"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../share/opam/bin/wayland-proxy-virtwl', 'wayland-proxy-virtwl'
    end
  end

  def self.postinstall
    puts <<~EOFSTRING.lightblue
      Note that there is not yet hardware acceleration in wayland-proxy-virtwl.
      wayland-proxy-virtwl example usage (before running a gui program):
    EOFSTRING
    puts <<~EOFSHELLCODE.lightcyan
      wayland-proxy-virtwl --wayland-display wayland-2 --x-display=2 --xrdb Xft.dpi:150 &
      export WAYLAND_DISPLAY=wayland-2
      export DISPLAY=:2
    EOFSHELLCODE
  end
end
