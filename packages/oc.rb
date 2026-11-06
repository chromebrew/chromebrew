require 'package'

class Oc < Package
  description 'Enterprise Kubernetes for Developers'
  homepage 'https://github.com/openshift/oc'
  version '5.0.0-202610271435'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/openshift/oc.git'
  git_hashtag "openshift-clients-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c84838bba0e733fb9f525d938170f3cd94ba4d9d7b9a533e78519ec5ccb7b6cf',
     armv7l: 'c84838bba0e733fb9f525d938170f3cd94ba4d9d7b9a533e78519ec5ccb7b6cf',
     x86_64: '566949b88cef10e539fbc959bcf8a6001d2c092ebd46c2fa39cef130177ca13f'
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
