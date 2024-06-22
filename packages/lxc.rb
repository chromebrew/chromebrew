require 'buildsystems/meson'

class Lxc < Meson
  description 'Linux Containers'
  homepage 'https://linuxcontainers.org'
  version '6.0.0'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://github.com/lxc/lxc.git'
  git_hashtag "v#{version}"

  depends_on 'libseccomp' # R
  depends_on 'libcap'     # R
  depends_on 'wget2'      # needed by lxc-download

  meson_options <<~EOF
    -Dlocalstatedir=#{CREW_PREFIX}/var \
    -Druntime-path=#{CREW_PREFIX}/run \
    -Dinit-script=[] \
    -Ddbus=false \
    -Dapparmor=false \
    -Dselinux=false \
    -Dexamples=false \
    -Dtests=false \
    -Dman=false \\
  EOF

  def self.patch
    # fix cgroup path
    system 'sed', '-i', 's/cpuset\.//g', 'src/lxc/cgroups/cgfsng.c'
  end
end
