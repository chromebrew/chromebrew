require 'buildsystems/autotools'

class Automake < Autotools
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.17'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/automake/automake-#{version}.tar.xz"
  source_sha256 'f01d58cd6d9d77fbdca9eb4bbd5ead1988228fdb73d6f7a201f5f8d6b118b469'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b991366b2b59e1c6bdbce17789552240019d7e4d175661dacf3533a66e584037',
     armv7l: 'b991366b2b59e1c6bdbce17789552240019d7e4d175661dacf3533a66e584037',
       i686: '0487cf58b02db8a932cb4c8691460d8f3034d154d9905e23be5ab96f442c0445',
     x86_64: 'e5bd0e72355c5aaaed40a118f253fe3004cb44a8f7325f79708820b4596d396a'
  })

  depends_on 'autoconf'
end
