require_relative '../lib/const'

class Command
  def self.sysinfo(verbose)
    # newer version of Chrome OS exports info to env by default
    lsb_release = if File.file?('/etc/lsb-release')
                    File.read('/etc/lsb-release').scan(/^(.+?)=(.+)$/).to_h
                  else
                    # newer version of Chrome OS exports info to env by default
                    ENV
                  end

    git_commit_message_format = '%h `%s (%cr)`'

    sysinfo_markdown_header = <<~MDHEADER
      <details><summary>Expand</summary>

    MDHEADER
    sysinfo_markdown_body = <<~MDBODY
      - Architecture: `#{KERN_ARCH}` (`#{ARCH}`)
      - Processor vendor: `#{CPUINFO['vendor_id'] || 'ARM'}`
      - User space: `#{Dir.exist?('/lib64') ? '64' : '32'}-bit`
      - Chromebrew Kernel version: `#{CREW_KERNEL_VERSION}`
      - Chromebrew Running in Container: `#{CREW_IN_CONTAINER}`

      - Chromebrew version: `#{CREW_VERSION}`
      - Chromebrew prefix: `#{CREW_PREFIX}`
      - Chromebrew libdir: `#{CREW_LIB_PREFIX}`

      - Last update in local repository: #{`git -C '#{CREW_LIB_PATH}' show -s --format='#{git_commit_message_format}'`.chomp}

      - OS variant: `#{lsb_release['CHROMEOS_RELEASE_NAME']}`
      - OS version: `#{lsb_release['CHROMEOS_RELEASE_BUILDER_PATH']}`
      - OS channel: `#{lsb_release['CHROMEOS_RELEASE_TRACK']}`
    MDBODY
    sysinfo_markdown_footer = <<~MDFOOTER

      </details>
    MDFOOTER
    if verbose
      puts sysinfo_markdown_header, sysinfo_markdown_body, sysinfo_markdown_footer
    else
      puts sysinfo_markdown_body.tr('`', '')
    end
  end
end
