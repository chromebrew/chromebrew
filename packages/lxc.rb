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

    # use `date` from coreutils
    # FIXME: Remove `date` binary from `zoneinfo`
    # meson.build:310:16: ERROR: Command `/usr/local/bin/date --utc --date=@1719046192 +%Y-%m-%d` failed with status 1.
    system 'sed', '-i', "s,find_program('date'),'date',g", 'meson.build'
    system 'sed', '-i', "s,'date','/bin/date',g", 'meson.build'
  end
end
