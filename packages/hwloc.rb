require 'buildsystems/autotools'

class Hwloc < Autotools
  description 'Portable Hardware Locality is a portable abstraction of hierarchical architectures'
  homepage 'https://www.open-mpi.org/projects/hwloc/'
  version '2.15.0'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/open-mpi/hwloc.git'
  git_hashtag "hwloc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7696c5b9f5e9c3983d80aa9e0aa86b4464ddc2c32514d8693c0f9807ceb2fd8b',
     armv7l: '7696c5b9f5e9c3983d80aa9e0aa86b4464ddc2c32514d8693c0f9807ceb2fd8b',
       i686: '63615a1291764efb9724dde4d5e8a9ea69e3e477631acc542e4ef08da1f369fd',
     x86_64: '8a6d220a707b66be4f0798c7a2e6bac147ae16ebac498892081a5805cd87f1a5'
  })

  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libpciaccess' => :library
  depends_on 'libxml2' => :library
  depends_on 'pciutils' => :build

  autotools_configure_options '--disable-cairo --enable-plugins'
end
