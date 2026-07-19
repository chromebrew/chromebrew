require 'package'

class Oc < Package
  description 'Enterprise Kubernetes for Developers'
  homepage 'https://github.com/openshift/oc'
  version '4.22.0-202605222050'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/openshift/oc.git'
  git_hashtag "openshift-clients-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3db6c535c4081c126b63fd87fc50a0ac44fcf714ef5f00fc2cb3ba2116f037ec',
     armv7l: '3db6c535c4081c126b63fd87fc50a0ac44fcf714ef5f00fc2cb3ba2116f037ec',
     x86_64: 'e2eb56a4a35cc67c51e9ecbe934d1de2a481605dc35984f28780fc1118b206b5'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build
  depends_on 'gpgme' => :executable

  def self.patch
    # Fix /bin/sh: 1: set: Illegal option -o pipefail
    system "sed -i 's,set -euo pipefail && ,,' vendor/github.com/openshift/build-machinery-go/make/lib/version.mk"
  end

  def self.build
    system 'make oc'
  end

  def self.install
    FileUtils.install 'oc', "#{CREW_DEST_PREFIX}/bin/oc", mode: 0o755
  end
end
