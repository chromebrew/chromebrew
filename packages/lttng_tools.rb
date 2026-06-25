require 'buildsystems/autotools'

class Lttng_tools < Autotools
  description 'Linux Trace Toolkit: next generation is a modern toolkit for tracing Linux systems and applications.'
  homepage 'https://lttng.org/'
  version '2.15.1'
  license 'LGPL-2.1-only, MIT, GPL-2.0-only, GPL-3.0-or-later, BSD-2-Clause, BSD-3-Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://lttng.org/files/lttng-tools/lttng-tools-#{version}.tar.bz2"
  source_sha256 '8b6d4ba7ae2c036f7dafbb4e29717677411078f9a9d961b2dc7c1ba16273e9e9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7c24ebf1cbb9906862b5cfb2ff505d62f6f4c053c947d3fca34af58eb781f87',
     armv7l: 'e7c24ebf1cbb9906862b5cfb2ff505d62f6f4c053c947d3fca34af58eb781f87',
     x86_64: '929ddc3f761ebc170bd1350f0b80da1d5eeffab2f8dcd3bb33a6d7e4aefbb155'
  })

  depends_on 'babeltrace' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libkmod' => :executable
  depends_on 'liburcu' => :library
  depends_on 'libxml2' => :library
  depends_on 'lttng_ust' => :library
  depends_on 'popt' => :executable
end
